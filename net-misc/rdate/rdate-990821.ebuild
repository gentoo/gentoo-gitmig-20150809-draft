# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/net-misc/rdate,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821.ebuild,v 1.7 2002/08/01 11:59:03 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rdate uses the NTP server of your choice to syncronize/show the current time"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"
HOMEPAGE="http://www.freshmeat.net/projects/rdate"
KEYWORDS="x86 ppc"
LICENSE="GPL"
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

