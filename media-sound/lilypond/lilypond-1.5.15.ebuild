# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-1.5.15.ebuild,v 1.10 2004/05/17 16:07:34 usata Exp $

IUSE=""

DESCRIPTION="GNU Music Typesetter"
HOMEPAGE="http://lilypond.org/"
SRC_URI="http://www.lilypond.org/ftp/LilyPond/development/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.0-r4
	>=dev-util/guile-1.4-r3
	>=sys-devel/flex-2.5.4a-r4
	>=sys-devel/bison-1.28-r3
	>=sys-apps/texinfo-4.0-r3
	virtual/tetex"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS* CHANGES DEDICATION NEWS README.txt ROADMAP FAQ* VERSION
}
