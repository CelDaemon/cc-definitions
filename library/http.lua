--- @meta _

--- Make http.http_requests, sending and receiving data to a remote web server.
--- 
--- See [`Allowing access to local IPs`](https://tweaked.cc/guide/local_ips.html) to allow accessing servers running on your local network.
--- @class http
http = {}

--- @class http.request 
--- @field url string The url to request.
--- @field headers table<string, string>? Additional headers to send as part of this request.
--- @field timeout number? The connection timeout, in seconds.

--- @class http.http_request: http.request
--- @field binary boolean? Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
--- @field method string? Which HTTP method to use, for instance `"PATCH"` or `"DELETE"`.
--- @field redirect boolean? Whether to follow HTTP redirects. Defaults to true.

--- @class http.body_request: http.http_request
--- @field body string? The body of the POST request.


--- @class http.byte_response: fs.read_byte_handle

--- Make a HTTP GET request to the given url.
--- 
--- @param url string The url to request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary false? Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
--- @return http.response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.response? # The failing http response, if available.
function http.get(url, headers, binary) end

--- Make a HTTP GET request to the given url.
--- 
--- @param url string The url to request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary true Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
--- @return http.byte_response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.byte_response? # The failing http response, if available.
function http.get(url, headers, binary) end

--- Make a HTTP GET request to the given url.
--- 
--- @param request http.http_request Options for the request. See [`http.http_request`](lua://http.http_request) for details on how these options behave.
--- @return http.response | http.byte_response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.response | http.byte_response? # The failing http response, if available.
function http.get(request) end


--- Make a HTTP POST request to the given url.
--- 
--- @param url string The url to request.
--- @param body string The body of the POST request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary false? Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
--- @return http.response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.response? # The failing http response, if available.
function http.post(url, body, headers, binary) end

--- Make a HTTP POST request to the given url.
--- 
--- @param url string The url to request.
--- @param body string The body of the POST request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary true Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
--- @return http.byte_response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.byte_response? # The failing http response, if available.
function http.post(url, body, headers, binary) end

--- Make a HTTP POST request to the given url.
--- 
--- @param request http.body_request Options for the request. See [`http.http_request`](lua://http.http_request) for details on how these options behave.
--- @return http.response | http.byte_response? # The resulting http response, which can be read from. Or `nil`, when the http.http_request failed, such as in the event of a 404 error or connection timeout.
--- @return string? # A message detailing why the request failed.
--- @return http.response | http.byte_response? # The failing http response, if available.
function http.post(request) end


--- Asynchronously make a http.http_request to the given url.
--- 
--- This returns immediately, a [`http_success`](lua://event.http_success) or [`http_failure`](lua://event.http_failure) will be queued once the request has completed.
--- 
--- @see http.get For a synchronous way to make GET requests.
--- @see http.post For a synchronous way to make POST requests.
--- 
--- @param url string The url to request.
--- @param body string The body of the POST request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary true Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
function http.http_request(url, body, headers, binary) end

--- Asynchronously make a http.http_request to the given url.
--- 
--- This returns immediately, a [`http_success`](lua://event.http_success) or [`http_failure`](lua://event.http_failure) will be queued once the request has completed.
--- 
--- @see http.get For a synchronous way to make GET requests.
--- @see http.post For a synchronous way to make POST requests.
--- 
--- @param url string The url to request.
--- @param body string The body of the POST request.
--- @param headers table<string, string>? Additional headers to send as part of this request.
--- @param binary true Whether the [response handle](lua://fs.read_handle) should be opened in binary mode.
function http.http_request(url, body, headers, binary) end

--- Asynchronously make a http.http_request to the given url.
--- 
--- This returns immediately, a [`http_success`](lua://event.http_success) or [`http_failure`](lua://event.http_failure) will be queued once the request has completed.
--- 
--- @see http.get For a synchronous way to make GET requests.
--- @see http.post For a synchronous way to make POST requests.
--- 
--- @param request http.body_request Options for the request.
function http.http_request(request) end

--- Asynchronously determine whether a URL can be requested.
--- 
--- If this returns `true`, one should also listen for [`http_check`](lua://event.http_check) which will container further information about whether the URL is allowed or not.
--- 
--- @see http.checkURL For a synchronous version.   
--- 
--- @nodiscard
--- @param url string The URL to check.
--- @return boolean # Whether this url is valid. This does not imply that it is allowed - see the comment above.
--- @return string? # A reason why this URL is not valid (for instance, if it is malformed, or blocked).
function http.checkURLAsync(url) end

--- Determine whether a URL can be requested.
--- 
--- If this returns `true`, one should also listen for [`http_check`](lua://event.http_check) which will container further information about whether the URL is allowed or not.
--- 
--- ```lua
--- print(http.checkURL("https://example.tweaked.cc/"))
--- -- => true
--- print(http.checkURL("http://localhost/"))
--- -- => false Domain not permitted
--- print(http.checkURL("not a url"))
--- -- => false URL malformed
--- ```
--- 
--- @see http.checkURLAsync For an asynchronous version.
--- 
--- @nodiscard
--- @param url string The URL to check.
--- @return boolean # When this url is valid and can be requested via [`http.http_request`](lua://http.http_request).
--- @return string? # A reason why this URL is not valid (for instance, if it is malformed, or blocked).
function http.checkURL(url) end


--- A http response. 
--- This provides the same methods as a [`file`](lua://fs.read_handle), though provides several request specific methods.
--- 
--- @see http.http_request On how to make a http.http_request.
--- 
--- @class http.response: fs.read_handle
local response = {}

--- Returns the response code and response message returned by the server.
--- 
--- @nodiscard
--- @return number # The response code (i.e. 200).
--- @return string # The response message (i.e. "OK").
function response.getResponseCode() end

--- Get a table containing the response's headers, in a format similar to that required by [`http.http_request`](lua://http.http_request). 
--- If multiple headers are sent with the same name, they will be combined with a comma.
--- 
--- Make a request to example.tweaked.cc, and print the returned headers:
--- 
--- ```lua
--- local request = http.get("https://example.tweaked.cc")
--- print(textutils.serialize(request.getResponseHeaders()))
--- -- => {
--- --  [ "Content-Type" ] = "text/plain; charset=utf8",
--- --  [ "content-length" ] = 17,
--- --  ...
--- -- }
--- request.close()
--- ```
--- 
--- @nodiscard
--- @return table<string, string> # The response's headers.
function response.getResponseHeaders() end

--- Asynchronously open a websocket.
--- 
--- This returns immediately, a [`websocket_success`](lua://event.websocket_success) or [`websocket_failure`](lua://event.websocket_failure) will be queued once the request has completed.
--- 
--- @see event.websocket_success
--- @see event.websocket_failure
--- 
--- @param url string The websocket url to connect to. This should have the `ws://` or `wss://` protocol.
--- @param headers table<string, string>? Additional headers to send as part of the initial websocket connection.
function response.websocketAsync(url, headers) end

--- Asynchronously open a websocket.
--- 
--- This returns immediately, a [`websocket_success`](lua://event.websocket_success) or [`websocket_failure`](lua://event.websocket_failure) will be queued once the request has completed.
--- 
--- @see event.websocket_success
--- @see event.websocket_failure
--- 
--- @param request http.request Options for the websocket. See [`http.request`](lua://http.request) for details on how these options behave.
--- @return http.websocket_handle | false # The websocket connection. Or `false` if the websocket connection failed.
--- @return string? # An error message describing why the connection failed.
function response.websocketAsync(request) end

--- Open a websocket.
--- 
--- Connect to an echo websocket and send a message:
--- 
--- ```lua
--- local ws = assert(http.websocket("wss://example.tweaked.cc/echo"))
--- ws.send("Hello!") -- Send a message
--- print(ws.receive()) -- And receive the reply
--- ws.close()
--- ```
--- 
--- @param url string The websocket url to connect to. This should have the `ws://` or `wss://` protocol.
--- @param headers table<string, string>? Additional headers to send as part of the initial websocket connection.
function response.websocket(url, headers) end

--- A websocket, which can be used to send and receive messages with a web server.
--- 
--- @see http.websocket On how to open a websocket.
--- 
--- @class http.websocket_handle
local websocket_handle = {}

--- Wait for a message from the server.
--- 
--- Throws if the websocket has been closed.
--- 
--- @nodiscard
--- @param timeout number? The number of seconds to wait if no message is received.
--- @return string? # The received message. Or `nil`, if the websocket was closed while waiting, or if we timed out. 
--- @return boolean? # If this was a binary message.
function websocket_handle.receive(timeout) end

--- Send a websocket message to the connected server.
--- 
--- Throws if the message is too large, or if the websocket has been closed.
--- 
--- @param message string The message to send.
--- @param binary boolean? Whether this message should be treated as a binary message.
function websocket_handle.send(message, binary) end

--- Close this websocket. 
--- This will terminate the connection, meaning messages can no longer be sent or received along it.
function websocket_handle.close() end