#!/bin/bash

declare -a arguments

if [ "$COG_ARGV_0" == "" ]; then
  echo "Error: You must supply a domain to query"
fi

if [ "$COG_OPT_SERVER" != "" ]; then
  arguments+=("-h")
  arguments+=("${COG_OPT_SERVER}")
fi

if [ "$COG_OPT_PORT" != "" ]; then
  arguments+=("-p")
  arguments+=("${COG_OPT_PORT}")
fi

# Set template to use for rendering output
echo "COG_TEMPLATE: dig"

# Run the whois command.
result="$(whois "${arguments[@]}" "$COG_ARGV_0")"

echo $COG_OPT_SHORT
if [ "$COG_OPT_SHORT" != "" ]; then
  echo -e "${result}" | grep -E "^(Registrant|Admin|Tech)"
else
  echo -e "${result}"
fi
