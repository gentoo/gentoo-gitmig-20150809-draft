# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm4400/bcm4400-1.0.1.ebuild,v 1.6 2003/07/13 14:31:35 aliz Exp $

SRC_URI="http://www.nodomain.org/bcm4400-1.0.1.tar.gz"
DESCRIPTION="Driver for the bcm4400 gigabit card (in the form of kernel modules)."
HOMEPAGE="http://www.mikrolog.fi/Levyt/NET/BC4401.asp"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/src

src_compile() {
	check_KV
	mv Makefile Makefile.orig
	sed -e "s|\`uname -r\`|$KV|" \
		< Makefile.orig > Makefile
	emake || die
}

src_install() {
	make PREFIX=${D} install || die
}


