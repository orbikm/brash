function brash::array::append()
{
  local ref=$1
  shift
  local local_arr=(${!ref})
  local elements=($@)
  local_arr+=(${elements[@]})
  read -d"\0" $ref <<< "${local_arr[@]}"
}