# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm++-goodies/aewm++-goodies-1.0.ebuild,v 1.10 2005/06/30 18:16:13 josejx Exp $

inherit eutils

DESCRIPTION="Goodies for aewm++"
HOMEPAGE="http://sapphire.sourceforge.net/"
SRC_URI="mirror://sourceforge/sapphire/${P/-/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${PN/-/_}"

GOODIES="ae_fspanel-1.0 appbar-1.0 setrootimage-1.0"

src_unpack() {
	unpack ${A}
	# compatibility with ANSI C++ and GCC3.2
	cd ${S}
	epatch ${FILESDIR}/aewm++-goodies-gcc3-gentoo.patch
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
