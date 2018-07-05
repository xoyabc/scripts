#!/bin/bash
doSomeJob()
{
trap '' SIGHUP 
trap '' SIGINT

exec 1>/dev/null
exec 2>/dev/null

some_commands_that_you_want_do_execute

}

doSomeJob &
