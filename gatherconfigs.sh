#!/bin/sh
bind_config_dir=/etc/bind
zoneconfig=$bind_config_dir/named.conf.generated

cp -a $zoneconfig $zoneconfig.old
cat $bind_config_dir/zoneconfigs/* > $zoneconfig.new
mv $zoneconfig.new $zoneconfig
service bind9 reload
