# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /home/cvsroot/gentoo-x86/net-misc/rdate,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821.ebuild,v 1.13 2003/02/28 16:55:00 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rdate uses the NTP server of your choice to syncronize/show the current time"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"
HOMEPAGE="http://www.freshmeat.net/projects/rdate"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""

src_compile() {

	make || die

}

src_install () {

	dodir /usr/bin
	dodir /usr/share
	dodir /usr/share/man/man1
	make DESTDIR=${D} install || die
	dodoc README.linux

}

