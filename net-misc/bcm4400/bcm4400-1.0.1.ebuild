# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm4400/bcm4400-1.0.1.ebuild,v 1.3 2003/01/19 04:36:56 sethbc Exp $

SRC_URI="http://www.nodomain.org/bcm4400-1.0.1.tar.gz"
DESCRIPTION="Driver for the bcm4400 gigabit card (in the form of kernel modules)."
HOMEPAGE="http://www.mikrolog.fi/Levyt/NET/BC4401.asp"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/src

src_compile() {
	#eval $(head -n4 /usr/src/linux/Makefile | sed -e 's: = :=:')
	
	mv Makefile Makefile.orig
	check_KV
	#sed -e "s|\`uname -r\`|$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION|" \
	sed -e "s|\`uname -r\`|$KV|" \
		< Makefile.orig > Makefile
	emake || die
}

src_install() {
	make PREFIX=${D} install || die
}


