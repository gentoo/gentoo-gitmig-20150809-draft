# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libiec61883/libiec61883-1.0.0.ebuild,v 1.1 2005/05/30 05:58:00 chriswhite Exp $

inherit eutils

DESCRIPTION="library for capturing video (dv or mpeg2) over the IEEE 1394 bus"
HOMEPAGE="http://www.linux1394.org"
#AFAIK, this isn't mirrored on sourceforge like libraw1394.
SRC_URI="http://www.linux1394.org/dl/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-libs/libraw1394-1.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	libtoolize --copy --force
}

src_install () {
		make DESTDIR="${D}" install || die "installation failed"
		dodoc AUTHORS ChangeLog NEWS README
}
