# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aaron Blew <moath@oddbox.org>
# /home/cvsroot/gentoo-x86/net-misc/rdate,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="rdate uses the NTP server of your choice to syncronize/show the current time"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${A}"
HOMEPAGE="http://www.freshmeat.net/projects/rdate"

DEPEND=""

src_compile() {

    try make

}

src_install () {

	dodir /usr/bin
	dodir /usr/share
	dodir /usr/share/man/man1
    try make DESTDIR=${D} install
    dodoc README.linux

}

