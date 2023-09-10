function brash::test::begin()
{
  local test_name=$1
  local func_name=$2

  echo "Test '$test_name' starting..."
  $func_name
  if [ $? -ne 0 ]; then
    echo "[  FAILED ]"
  else
    echo "[ SUCCESS ]"
  fi
}

function brash::test::assert_eq()
{
  local lhs=$1
  local rhs=$2
}