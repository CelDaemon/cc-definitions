--- @meta _

--- Multishell allows multiple programs to be run at the same time.
--- 
--- When multiple programs are running, it displays a tab bar at the top of the screen, which allows you to switch between programs. 
--- New programs can be launched using the `fg` or `bg` programs, or using the [`shell.openTab`](lua://shell.openTab) and [`multishell.launch`](lua://multishell.launch) functions.
--- 
--- Each process is identified by its ID, which corresponds to its position in the tab list. 
--- As tabs may be opened and closed, this ID is not constant over a program's run. 
--- As such, be careful not to use stale IDs.
--- 
--- As with [`shell`](lua://shell), [`multishell`](lua://multishell) is not a "true" API. 
--- Instead, it is a standard program, which launches a shell and injects its API into the shell's environment. 
--- This API is not available in the global environment, and so is not available to [`APIs`](lua://os.loadAPI).
--- @class multishelllib
multishell = {}

--- Get the currently visible process. This will be the one selected on the tab bar.
--- 
--- Note, this is different to [`getCurrent`](lua://multishell.getCurrent), which returns the process which is currently executing.
--- 
--- @see multishell.setFocus
--- 
--- @nodiscard
--- @return number # The currently visible process's index.
function multishell.getFocus() end

--- Change the currently visible process.
--- 
--- @see multishell.getFocus
--- 
--- @nodiscard
--- @param n number The process index to switch to.
--- @return boolean # If the process was changed successfully. This will return `false` if there is no process with this id.
function multishell.setFocus(n) end

--- Get the title of the given tab.
--- 
--- This starts as the name of the program, but may be changed using [`multishell.setTitle`](lua://multishell.setTitle).
--- 
--- @nodiscard
--- @param n number The process index.
--- @return string? # The current process title, or `nil` if the process doesn't exist.
function multishell.getTitle(n) end

--- Set the title of the given process.
--- 
--- Change the title of the current process:
--- 
--- ```lua
--- multishell.setTitle(multishell.getCurrent(), "Hello")
--- ```
--- 
--- @see multishell.getTitle
--- 
--- @param n number The process index.
--- @param title string The new process title.
function multishell.setTitle(n, title) end

--- Get the index of the currently running process.
--- 
--- @nodiscard
--- @return number # The currently running process.
function multishell.getCurrent() end

--- Start a new process, with the given environment, program and arguments.
--- 
--- The returned process index is not constant over the program's run. 
--- It can be safely used immediately after launching (for instance, to update the title or switch to that tab). 
--- However, after your program has yielded, it may no longer be correct.
--- 
--- Run the "hello" program, and set its title to "Hello!":
--- 
--- ```lua
--- local id = multishell.launch({}, "/rom/programs/fun/hello.lua")
--- multishell.setTitle(id, "Hello!")
--- ```
--- 
--- @see os.run
--- 
--- @param programEnv table The environment to load the path under.
--- @param programPath string The path to the program to run.
--- @param ... string Additional arguments to pass to the program.
--- @return number # The index of the created process.
function multishell.launch(programEnv, programPath, ...) end

--- Get the number of processes within this multishell.
--- 
--- @nodiscard
--- @return number # The number of processes.
function multishell.getCount() end