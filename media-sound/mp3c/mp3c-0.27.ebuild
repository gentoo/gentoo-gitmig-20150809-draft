# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3c/mp3c-0.27.ebuild,v 1.11 2005/09/04 11:02:56 flameeyes Exp $

IUSE=""
DESCRIPTION="console based mp3 ripper, with cddb support"
HOMEPAGE="http://mp3c.wspse.de/WSPse/Linux-MP3c.php3?lang=en"
SRC_URI="ftp://excelsior.kullen.rwth-aachen.de/pub/linux/wspse/${P}.tar.gz"
DEPEND=">=media-sound/bladeenc-0.94.2 \
	>=media-sound/cdparanoia-3.9.8 \
	>=media-sound/mp3info-0.8.4-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc AUTHORS *README BUGS CDDB_HOWTO ChangeLog FAQ NEWS OTHERS TODO
}
