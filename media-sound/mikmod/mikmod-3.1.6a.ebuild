# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.1.6a.ebuild,v 1.2 2003/07/02 21:21:40 aliz Exp $

MY_P=${PN}-${PV/a}
DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://www.mikmod.org/"
LICENSE="GPL-2"
SRC_URI="http://www.mikmod.org/files/mikmod/${MY_P}.tar.gz
	http://www.mikmod.org/files/patches/patch-${MY_P}-a"
S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/libmikmod-3.1.5"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${MY_P}.tar.gz ; cd ${S}
	epatch ${DISTDIR}/patch-${MY_P}-a
	epatch ${FILESDIR}/${MY_P}-security.patch
}

src_compile() {
	econf || die
        	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
