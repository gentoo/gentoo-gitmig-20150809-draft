# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/horgand/horgand-0.91.ebuild,v 1.8 2004/07/14 20:47:38 agriffis Exp $

DESCRIPTION="horgand is an opensource software organ."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	media-sound/jack-audio-connection-kit"

src_compile() {
	emake || die "compile failed"
}

src_install() {
	cp Makefile Makefile~
	sed -e "s:PREFIX = /usr/local:PREFIX = /usr:" Makefile~ > Makefile

	dodir /usr/bin

	einstall DESTDIR=${D}

	prepalldocs
}
