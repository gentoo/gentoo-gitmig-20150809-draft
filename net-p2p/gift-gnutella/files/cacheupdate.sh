#!/bin/bash
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/files/cacheupdate.sh,v 1.1 2004/09/12 04:26:26 squinky86 Exp $

if [ -d ~/.giFT/Gnutella/ ]; then
	cd ~/.giFT/Gnutella
	wget http://gwebcache.squinky.gotdns.com/perlgcache.cgi?get=1\&hostfile=1\&net=gnutella2\&client=GEN2\&version=0.1 -O gwebcaches.new || die
	grep "u|" gwebcaches.new > gwebcaches.new1
	sed -i -e 's:u|::g' gwebcaches.new1
	sed -i -e 's:|.*::g' gwebcaches.new1
	mv gwebcaches.new1 gwebcaches
	rm gwebcaches.new
else
	echo "Please emerge gift-gnutella and run gift-setup."
fi
