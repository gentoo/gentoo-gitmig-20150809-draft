# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sfc/sfc-0.012.ebuild,v 1.1 2003/06/13 10:21:48 robh Exp $


DESCRIPTION="SoundFontCombi is a opensource software pseudo synthesizer."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	virtual/alsa"

S="${WORKDIR}/${P}"

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


