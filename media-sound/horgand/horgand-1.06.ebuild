# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/horgand/horgand-1.06.ebuild,v 1.2 2004/03/21 04:17:36 eradicator Exp $

DESCRIPTION="horgand is an opensource software organ."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://download.berlios.de/horgand/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	media-libs/libsndfile
	media-libs/alsa-lib
	virtual/jack"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
