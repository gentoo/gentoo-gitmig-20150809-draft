#!/bin/bash
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/files/cacheupdate.sh,v 1.8 2006/09/02 14:20:39 squinky86 Exp $

CACHE=http://loot.alumnigroup.org/

if [ -d ~/.giFT/Gnutella/ ]; then
	cd ~/.giFT/Gnutella
	wget ${CACHE}?urlfile=1\&client=GEN2\&version=0.2 -O gwebcaches.new || die "Unable to retrieve new caches."
	if [ "`grep ERROR gwebcaches.new`" ]; then
		cat gwebcaches.new
	else
		mv gwebcaches.new gwebcaches
	fi
	wget ${CACHE}?hostfile=1\&client=GEN2\&version=0.2 -O nodes.new || die "Unable to retrieve new hosts."
	if [ "`grep ERROR nodes.new`" ]; then
		cat nodes.new
	else
		mv nodes.new nodes
	fi
	echo "Update complete!"
else
	echo "Please emerge gift-gnutella and run gift-setup."
fi
