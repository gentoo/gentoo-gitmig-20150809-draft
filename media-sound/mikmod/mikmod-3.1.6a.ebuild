# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.1.6a.ebuild,v 1.8 2004/03/31 18:48:51 eradicator Exp $

inherit eutils

MY_P=${PN}-${PV/a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	mirror://gentoo/patch-${MY_P}-a"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libmikmod-3.1.5"

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
