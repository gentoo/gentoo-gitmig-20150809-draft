# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sfc/sfc-0.012.ebuild,v 1.4 2004/04/01 07:58:09 eradicator Exp $


DESCRIPTION="SoundFontCombi is a opensource software pseudo synthesizer."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	virtual/alsa"

src_compile() {
	emake || die "compile failed"
}

src_install() {
	cp Makefile Makefile~
	sed -e "/^PREFIX/s:.*:PREFIX = /usr:
		/^DOC_DIR/s:.*:DOC_DIR = /usr/share/doc/${P}:" Makefile~ > Makefile

	dodir /usr/bin

	einstall DESTDIR=${D}

	prepalldocs
}
