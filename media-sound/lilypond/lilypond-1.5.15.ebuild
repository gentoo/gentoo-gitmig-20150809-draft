# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-1.5.15.ebuild,v 1.4 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://www.lilypond.org/ftp/LilyPond/development/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.0-r4
	>=dev-util/guile-1.4-r3
	>=sys-devel/flex-2.5.4a-r4
	>=sys-devel/bison-1.28-r3
	>=sys-apps/texinfo-4.0-r3
	>=app-text/tetex-1.0.7-r2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die

	dodoc AUTHORS* CHANGES DEDICATION NEWS README.txt ROADMAP FAQ* VERSION
}
