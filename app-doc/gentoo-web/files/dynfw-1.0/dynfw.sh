args() {
	if [ "${1}" != "${2}" ]
	then 
		echo
		echo "Gentoo Linux Dynamic Firewall Scripts 1.0"
		echo "Copyright 2001 Gentoo Technologies, Inc."
		echo "Distributed under the GPL"
		echo "contact: <drobbins@gentoo.org>"
		echo
		echo "${1} arguments expected."
		echo
		echo "Usage: ${3}"
		echo
		echo "Description: ${4}"
		echo
		exit 1
	fi
}	

rec_check() {
	local isthere
	local doerror
	isthere="no"
	if [ -e /root/.dynfw-${1} ]
	then
		myinfo=`cat /root/.dynfw-${1} | grep ^${2}`
		if [ "$myinfo" != "" ]
		then
			isthere="yes"
		fi
	fi
	doerror="no"
	if [ "${4}" = "on" ]
	then
		if [ "${isthere}" = "yes" ]
		then
			doerror="yes"
		fi
	elif [ "${isthere}" = "no" ]
	then
		doerror="yes"
	fi
	if [ "${doerror}" = "yes" ]
	then
		echo "Oops: ${3}. Exiting."
		exit 1
	fi
}

record() {
	echo $2 >> /root/.dynfw-${1}
}

unrecord() {
	if [ ! -e /root/.dynfw-${1}	]
	then
		return
	fi
	myinfo=`cat /root/.dynfw-${1} | grep -v "^${2}"`
	rm /root/.dynfw-${1}
	for x in $myinfo
	do
		echo $x >> /root/.dynfw-${1}
	done
}
