#!/bin/bash
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/files/cacheupdate.sh,v 1.6 2004/10/29 19:42:42 squinky86 Exp $

if [ -d ~/.giFT/Gnutella/ ]; then
	cd ~/.giFT/Gnutella
	wget http://loot.alumnigroup.org/?get=1\&hostfile=1\&net=gnutella2\&client=GEN2\&version=0.1 -O gwebcaches.new || die "Unable to retrieve new caches."
	grep "u|" gwebcaches.new > gwebcaches.new1
	sed -i -e 's:u|::g' gwebcaches.new1
	sed -i -e 's:|.*::g' gwebcaches.new1
	mv gwebcaches.new1 gwebcaches
	grep "h|" gwebcaches.new | grep -v "ph|" > nodes.new
	sed -i -e 's:h|::g' nodes.new
	sed -i -e 's:|.*::g' nodes.new
	mv nodes.new nodes
	rm gwebcaches.new
	echo "Update complete!"
else
	echo "Please emerge gift-gnutella and run gift-setup."
fi
