#!/bin/bash
# Copyright (c) 2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Contributed by Roy Marples (uberlord@gentoo.org)

# If we have a service specific script, run this now
if [[ -x /etc/openvpn/"${SVCNAME}"-down.sh ]] ; then
	( /etc/openvpn/"${SVCNAME}"-down.sh )
fi

# Setup our resolv.conf
[[ -x /sbin/resolvconf ]] && /sbin/resolvconf -d "${dev}"

# Re-enter the init script to start any dependant services
if /etc/init.d/"${SVCNAME}" --quiet status ; then
	export IN_BACKGROUND=true
	/etc/init.d/"${SVCNAME}" --quiet stop
fi

exit 0

# vim: ts=4 :
