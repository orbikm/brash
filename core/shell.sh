function brash::script_dir()
{
  echo $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
}

function brash::var::exists()
{
  local varname=$1
  echo "Array length: ${!varname[@]}"
  if [ ${!varname[@]} -gt 0 ]; then
    return 1
  else
    return 0
  fi
}