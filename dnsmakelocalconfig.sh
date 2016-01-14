#!/bin/sh
bind_zone_configs_dir=/etc/bind/zoneconfigs
while getopts ":z:i:r" option; do
  case $option in
    z)
      zonename="$OPTARG" >&2
      ;;
    i)
      ip="$OPTARG" >&2
      ;;
    r)
      removeflag="remove" <&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [ "$zonename" != "" ] && [ "$ip"  != "" ];then
cat>"$bind_zone_configs_dir/$zonename"<<EOF
zone "$zonename." {
        type master;
        file "/etc/bind/zones/db.test";
};
EOF
elif [ "$zonename" != "" ] && [ "$removeflag"  != "" ] && [ -f $bind_zone_configs_dir/$zonename ];then
  echo "$zonename removed from list";
  rm $bind_zone_configs_dir/$zonename
elif [ ! -f $bind_zone_configs_dir/$zonename ] && [ "$zonename" != "" ];then
  echo "$zonename not found"
elif [ "$zonename" != "" ] && [ "$ip"  == "" ] && [ "$resetflag"  == "" ];then
  echo "Missing or incorrect options set";
else
  echo "Something went wrong."
fi
