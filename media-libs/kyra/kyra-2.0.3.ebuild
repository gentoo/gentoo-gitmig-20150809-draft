# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/kyra/kyra-2.0.3.ebuild,v 1.2 2003/07/12 18:05:48 aliz Exp $

DESCRIPTION="Kyra Sprite Engine"
HOMEPAGE="http://www.grinninglizard.com/kyra/index.html"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/kyra/kyra_src_2_0_3.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.0"

S=${WORKDIR}/${PN}

src_compile() {

	econf
	emake || die
}

src_install() {

	einstall
}
