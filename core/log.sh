function brash::log()
{
  echo "${@}"
}

function brash::loge()
{
  >&2 echo "${@}"
}