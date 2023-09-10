function brash::map::declare()
{
  local map_name=$1
  local map_keys_ref="BRASH_MAP__${map_name}__KEYS"
  local local_map_keys=(${!map_keys_ref})
  if [ ${#local_map_keys[@]} -eq 0 ]; then
    export $map_keys_ref
  fi
}

function brash::map::set()
{
  local map_name=$1
  local key_name=$2
  shift 2
  local value=$@

  # Reference vars
  local map_keys_ref="BRASH_MAP__${map_name}__KEYS"
  local map_val_ref="BRASH_MAP__${map_name}__${key_name}__VAL"

  # Check if map key value exists, if not export it as a global
  local local_val=${!map_val_ref}
  if [ ! -z ${!map_val_ref+x} ];then
    export $map_val_ref
  fi

  # Add to keys
  local local_keys=${!map_keys_ref}
  local_keys+=($key_name)

  # Update the keys and value reference vars
  read -d"\0" $map_keys_ref <<< ${local_keys[@]}
  read -d"\0" $map_val_ref <<< $value
}

function brash::map::has()
{
  local map_name=$1
  local key=$2
  local map_keys_ref="BRASH_MAP__${map_name}__KEYS"
  local local_map_keys=(${!map_keys_ref})
  for el in "${local_map_keys[@]}"; do
    if [ "$el" = "$key" ]; then
      return 1
    fi
  done
  return 0
}

alias brash::map::contains=brash::map::has

function brash::map::get()
{
  local map_name=$1
  local key_name=$2

  brash::map::has $map_name $key_name
  if [[ "$?" -eq 1 ]]; then
    local map_val_ref="BRASH_MAP__${map_name}__${key_name}__VAL"
    echo "${!map_val_ref}"
  fi
}

function brash::map::get_or()
{
  local map_name=$1
  local key_name=$2
  local or_val=$3

  brash::map::has $map_name $key_name
  if [[ "$?" -eq 1 ]]; then
    local map_val_ref="BRASH_MAP__${map_name}__${key_name}__VAL"
    echo "${!map_val_ref}"
  else
    echo "${or_val}"
  fi
}