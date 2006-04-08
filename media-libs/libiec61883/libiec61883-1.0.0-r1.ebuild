# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libiec61883/libiec61883-1.0.0-r1.ebuild,v 1.3 2006/04/08 12:20:50 blubb Exp $

inherit autotools eutils

DESCRIPTION="library for capturing video (dv or mpeg2) over the IEEE 1394 bus"
HOMEPAGE="http://www.linux1394.org"
#AFAIK, this isn't mirrored on sourceforge like libraw1394.
SRC_URI="http://www.linux1394.org/dl/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="examples"

DEPEND=">=sys-libs/libraw1394-1.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	libtoolize --copy --force

	if use examples
	then
		sed -i -e "s:noinst_PROGRAMS.*:noinst_PROGRAMS = :g" \
		-e "s:in_PROGRAMS.*:in_PROGRAMS = plugreport plugctl test-amdtp test-dv	test-mpeg2 test-plugs:g" \
		examples/Makefile.am || die "noinst patching failed"
		eautoreconf
	fi
}

src_install () {
		make DESTDIR="${D}" install || die "installation failed"
		dodoc AUTHORS ChangeLog NEWS README
}
