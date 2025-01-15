--- @meta _

--- Communicate with other computers by using [`modems`](lua://peripheral.modem). 
--- [`rednet`](lua://rednet) provides a layer of abstraction on top of the main [`modem`](lua://peripheral.modem) peripheral, making it slightly easier to use.
--- 
--- ## Basic usage
--- 
--- In order to send a message between two computers, each computer must have a modem on one of its sides (or in the case of pocket computers and turtles, the modem must be equipped as an upgrade). 
--- The two computers should then call [`rednet.open`](lua://rednet.open), which sets up the modems ready to send and receive messages.
--- 
--- Once rednet is opened, you can send messages using [`rednet.send`](lua://rednet.send) and receive them using [`rednet.receive`](lua://rednet.receive). 
--- It's also possible to send a message to every rednet-using computer using [`rednet.broadcast`](lua://rednet.broadcast).
--- 
--- > Network security:
--- > While rednet provides a friendly way to send messages to specific computers, it doesn't provide any guarantees about security. 
--- > Other computers could be listening in to your messages, or even pretending to send messages from other computers!
--- > 
--- > If you're playing on a multi-player server (or at least one where you don't trust other players), it's worth encrypting or signing your rednet messages.
--- 
--- ## Protocols and hostnames
--- 
--- Several rednet messages accept "protocol"s - simple string names describing what a message is about. 
--- When sending messages using [`rednet.send`](lua://rednet.send) and [`rednet.broadcast`](lua://rednet.broadcast), you can optionally specify a protocol for the message. 
--- This same protocol can then be given to [`rednet.receive`](lua://rednet.receive), to ignore all messages not using this protocol.
--- 
--- It's also possible to look-up computers based on protocols, providing a basic system for service discovery and [DNS](https://en.wikipedia.org/wiki/Domain_Name_System). 
--- A computer can advertise that it supports a particular protocol with [`rednet.host`](lua://rednet.host), also providing a friendly "hostname". 
--- Other computers may then find all computers which support this protocol using [`rednet.lookup`](lua://rednet.lookup).
--- 
--- @see event.rednet_message Queued when a rednet message is received.
--- @see peripheral.modem Rednet is built on top of the modem peripheral. Modems provide a more bare-bones but flexible interface.
--- @class rednet
rednet = {}

--- The channel used by the Rednet API to [`broadcast`](lua://rednet.broadcast) messages.
rednet.CHANNEL_BROADCAST = 65535

--- The channel used by the Rednet API to repeat messages.
rednet.CHANNEL_REPEAT = 65533

--- The number of channels rednet reserves for computer IDs. Computers with IDs greater or equal to this limit wrap around to 0.
rednet.MAX_ID_CHANNELS = 65500

--- Opens a modem with the given [`peripheral`](lua://peripheral) name, allowing it to send and receive messages over rednet.
--- This will open the modem on two channels: one which has the same [ID](lua://os.getComputerID) as the computer, and another on [the broadcast channel](lua://rednet.CHANNEL_BROADCAST).
--- 
--- Throws if there is no such modem with the given name.
--- 
--- Open rednet on the back of the computer, allowing you to send and receive rednet messages using it:
--- 
--- ```lua
--- rednet.open("back")
--- ```
--- 
--- Open rednet on all attached modems. This abuses the "filter" argument to [`peripheral.find`](lua://peripheral.find):
--- 
--- ```lua
--- peripheral.find("modem", rednet.open)
--- ```
--- 
--- @see rednet.close
--- @see rednet.isOpen
--- 
--- @param modem peripheral.name The name of the modem to open.
function rednet.open(modem) end

--- Close a modem with the given [`peripheral`](lua://peripheral) name, meaning it can no longer send and receive rednet messages.
--- 
--- Throws if there is no such modem with the given name.
--- 
--- @see rednet.open
--- 
--- @param modem string? The side the modem exists on. If not given, all open modems will be closed.
function rednet.close(modem) end

--- Determine if rednet is currently open.
--- 
--- @see rednet.open
--- 
--- @nodiscard
--- @param modem string? Which modem to check. If not given, all connected modems will be checked.
--- @return boolean # If the given modem is open.
function rednet.isOpen(modem) end

--- Allows a computer or turtle with an attached modem to send a message intended for a computer with a specific ID. 
--- At least one such modem must first be [opened](lua://rednet.open) before sending is possible.
--- 
--- Assuming the target was in range and also had a correctly opened modem, the target computer may then use [`rednet.receive`](lua://rednet.receive) to collect the message.
--- 
--- Send a message to computer #2:
--- 
--- ```lua
--- rednet.send(2, "Hello from rednet!")
--- ```
--- 
--- @see rednet.receive
--- 
--- @nodiscard
--- @param recipient number The ID of the receiving computer.
--- @param message textutils.value The message to send. Like with [`modem.transmit`](lua://modem.transmit), this can contain any primitive type (numbers, booleans and strings) as well as tables. Other types (like functions), as well as metatables, will not be transmitted.
--- @param protocol string? The "protocol" to send this message under. When using [`rednet.receive`](lua://rednet.receive) one can filter to only receive messages sent under a particular protocol.
--- @return boolean # If this message was successfully sent (i.e. if rednet is currently [`open`](lua://rednet.open)). Note, this does not guarantee the message was actually received.
function rednet.send(recipient, message, protocol) end

--- Broadcasts a string message over the predefined [`CHANNEL_BROADCAST`](lua://rednet.CHANNEL_BROADCAST) channel. 
--- The message will be received by every device listening to rednet.
--- 
--- Broadcast the words "Hello, world!" to every computer using rednet:
--- 
--- ```lua
--- rednet.broadcast("Hello, world!")
--- ```
--- 
--- @see rednet.receive
--- 
--- @param message textutils.value The message to send. This should not contain coroutines or functions, as they will be converted to `nil`.
--- @param protocol string? The "protocol" to send this message under. When using [`rednet.receive`](lua://rednet.receive) one can filter to only receive messages sent under a particular protocol.
function rednet.broadcast(message, protocol) end

--- Wait for a rednet message to be received, or until `nTimeout` seconds have elapsed.
--- 
--- Receive a rednet message:
--- 
--- ```lua
--- local id, message = rednet.receive()
--- print(("Computer %d sent message %s"):format(id, message))
--- ```
--- 
--- Receive a message, stopping after 5 seconds if no message was received:
--- 
--- ```lua
--- local id, message = rednet.receive(nil, 5)
--- if not id then
---     printError("No message received")
--- else
---     print(("Computer %d sent message %s"):format(id, message))
--- end
--- ```
--- 
--- Receive a message from computer #2:
--- 
--- ```lua
--- local id, message
--- repeat
---     id, message = rednet.receive()
--- until id == 2
--- 
--- print(message)
--- ```
--- 
--- @see rednet.broadcast
--- @see rednet.send
--- 
--- @param protocol_filter string? The protocol the received message must be sent with. If specified, any messages not sent under this protocol will be discarded.
--- @param timeout number? The number of seconds to wait if no message is received.
--- @return number? # The computer which sent this message. Or `nil`, if the timeout elapsed and no message was received.
--- @return textutils.value? # The received message.
--- @return string? # The protocol this message was sent under.
function rednet.receive(protocol_filter, timeout) end

--- Register the system as "hosting" the desired protocol under the specified name. 
--- If a rednet [`lookup`](lua://rednet.lookup) is performed for that protocol (and maybe name) on the same network, the registered system will automatically respond via a background process, hence providing the system performing the lookup with its ID number.
--- 
--- Multiple computers may not register themselves on the same network as having the same names against the same protocols, and the title `localhost` is specifically reserved. 
--- They may, however, share names as long as their hosted protocols are different, or if they only join a given network after "registering" themselves before doing so (eg while offline or part of a different network).
--- 
--- Throws if trying to register a hostname which is reserved, or currently in use.
--- 
--- @see rednet.unhost
--- @see rednet.lookup
--- 
--- @param protocol string The protocol this computer provides.
--- @param hostname string The name this computer exposes for the given protocol.
function rednet.host(protocol, hostname) end

--- Stop [`hosting`](lua://rednet.host) a specific protocol, meaning it will no longer respond to [`rednet.lookup`](lua://rednet.lookup) requests.
--- 
--- @param protocol string The protocol to unregister your self from.
function rednet.unhost(protocol) end

--- Search the local rednet network for systems [`hosting`](lua://rednet.host) the desired protocol and returns any computer IDs that respond as "registered" against it.
--- 
--- If a hostname is specified, only one ID will be returned (assuming an exact match is found).
--- 
--- Find all computers which are hosting the `"chat"` protocol:
--- 
--- ```lua
--- local computers = {rednet.lookup("chat")}
--- print(#computers .. " computers available to chat")
--- for _, computer in pairs(computers) do
---   print("Computer #" .. computer)
--- end
--- ```
--- 
--- Find a computer hosting the `"chat"` protocol with a hostname of `"my_host"`:
--- 
--- ```lua
--- local id = rednet.lookup("chat", "my_host")
--- if id then
---   print("Found my_host at computer #" .. id)
--- else
---   printError("Cannot find my_host")
--- end
--- ```
--- 
--- @param protocol string The protocol to search for.
--- @param hostname string? The hostname to search for.
--- @return number? ... A list of computer IDs hosting the given protocol, or `nil` if none exists.
function rednet.lookup(protocol, hostname) end

--- Listen for modem messages and converts them into rednet messages, which may then be [`received`](lua://rednet.receive).
--- 
--- This is automatically started in the background on computer startup, and should not be called manually.
function rednet.run() end