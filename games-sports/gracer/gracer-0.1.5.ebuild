# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/gracer/gracer-0.1.5.ebuild,v 1.4 2004/03/24 04:54:25 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="3D motor sports simulator"
HOMEPAGE="http://gracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/gracer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gif jpeg png joystick"

RDEPEND="virtual/x11
	virtual/glu
	virtual/glut
	virtual/opengl
	dev-lang/tcl
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	media-libs/plib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gldefs.patch"
}

src_compile() {
	egamesconf \
		`use_enable joystick` \
		`use_enable gif` \
		`use_enable jpeg` \
		`use_enable png` \
			|| die
	sed -i \
		-e 's:-lplibsl:-lplibsl -lplibul:' `find -name Makefile` \
			|| die "sed Makefiles failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install           || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
	prepgamesdirs
}
