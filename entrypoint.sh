#!/bin/sh

# exit on error
set -e

# initialize data directory
init_data() {
	# create root directory
	mkdir -p ${DATA}/etc
	mkdir -p ${DATA}/var
	
	# if not directory /etc then create
	if [[ ! -d ${DATA}/etc/bind ]];
	then
		mv /etc/bind ${DATA}/etc/bind
	fi
	
	# empty old location
	rm -Rfv /etc/bind/*
	
	# link old location to new directory
	ln -sf ${DATA}/etc/bind /etc/bind


	# if not directory /var then create
	if [[ ! -d ${DATA}/var/bind ]];
	then
		mv /var/bind ${DATA}/var/bind
	fi
	
	# delete old location
	rm -Rfv /var/bind/*
	
	# link old location to new directory
	ln -sf ${DATA}/var/bind /var/bind
}

init_data

#check for bind configuration in default location
if [[ ! -f ${DATA}/etc/named.conf ]]
then
	echo "Please place your bind9 configuration in ${DATA}/etc/named.conf"
fi

# run CMD
echo "Running '$@'"
exec "$@"
