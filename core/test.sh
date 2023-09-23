

function brash::test::begin()
{
  local test_name=$1
  local func_name=$2
  shift 2
  local args=$@

  echo "Starting test '$test_name'..."
  eval $func_name $args
  if [ $? -ne 0 ]; then
    echo "[  FAILED ]"
  else
    echo "[ SUCCESS ]"
  fi
}

function brash::test::assert_eq_msg()
{
  local lhs=$1
  local rhs=$2
  local msg=$3

  if [ ! "$lhs" = "$rhs" ]; then
    brash::loge "Assertion failed: $msg.\nLHS: ${lhs}\nRHS: ${rhs}"
  fi
}

function brash::test::assert_eq()
{
  local lhs=$1
  local rhs=$2

  if [ ! "$lhs" = "$rhs" ]; then
    brash::loge "Assertion failed\n  - LHS: ${lhs}\n  - RHS: ${rhs}"
    brash::print_stack 1
  fi
}

function brash::test::assert_true()
{
  local condition=$1
  local msg=$2

}