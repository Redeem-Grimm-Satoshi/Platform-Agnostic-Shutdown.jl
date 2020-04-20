---
title: shutdown
tags: shellcommand,advance
---

Shutdown computer in a duration given by the user and message to be displayed stating the reason for shutdown.

Use variable `Sys.KERNEL` to handle differences between operating systems.
Use `@static` macro at beginning of expression for mutually exclusive subsets of isunix (Optional).
Use `run` function which take an object of type `osCommand` defined by enclosing a command string in backticks and execute
the required command for the operating system based on the conditions.

```jl
function shutdown(time,message)
  
  #Operating system commands
  windowsCommand=`cmd /c shutdown/s /t $time /c $message`
  linuxCommand=`sudo shutdown $time $message`
  appleCommand=`sudo shutdown -h +$time $message`
  freebsdCommand=`shutdown -h +$time $message`
  
  #Condition before command is executed based on OS
  if Sys.iswindows()==true
    run(windowsCommand)
  elseif Sys.islinux()==true
    run(linuxCommand)
  elseif Sys.isapple()==true
    run(appleCommand)
  elseif Sys.isfreebsd()==true
    run(freebsdCommand)
  else
    println("Operating system not supported!")
   end
end
```

```jl
shutdown(400,"Fatal System Error! Blue Screen Loading..") # Dialogue box appear showing "Fatal System Error! Blue Screen Loading" and computer shutdown in 400sec.
```
