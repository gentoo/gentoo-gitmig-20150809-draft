# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm++-goodies/aewm++-goodies-1.0.ebuild,v 1.4 2004/01/08 02:05:03 avenj Exp $

IUSE=""

DESCRIPTION="Goodies for aewm++."
HOMEPAGE="http://sapphire.sourceforge.net/"
SRC_URI="mirror://sourceforge/sapphire/${P/-/_}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
DEPEND="virtual/x11"

S="${WORKDIR}/${PN/-/_}"

GOODIES="ae_fspanel-1.0 appbar-1.0 setrootimage-1.0"

src_unpack() {
	unpack ${A}
	# compatibility with ANSI C++ and GCC3.2
	cd ${S} && patch -p1 <${FILESDIR}/aewm++-goodies-gcc3-gentoo.patch || die
}

src_compile() {
	for i in ${GOODIES}
	do
		make CFLAGS="${CFLAGS}" -C $i || die
	done
}

src_install() {
	dodir /usr/bin
	for i in ${GOODIES}
	do
		make DESTDIR=${D} -C $i install || die
		docinto $i
		dodoc $i/{README,ChangeLog,COPYING,LICENSE}
	done
}
