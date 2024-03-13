command_exists ()
{
  if [ -z "$1" ] || ! command -v "$1" &> /dev/null
  then
    return 1
  else
    return 0
  fi
}
