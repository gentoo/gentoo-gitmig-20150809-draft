# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sfftobmp/sfftobmp-3.0.ebuild,v 1.8 2007/01/04 13:25:57 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit autotools

MY_P=${PN}_${PV/./_}
S=${WORKDIR}/${MY_P}

DESCRIPTION="sff to bmp converter"
HOMEPAGE="http://sfftools.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfftools/${MY_P}_src.zip"

SLOT="0"
IUSE=""
LICENSE="as-is"
KEYWORDS="amd64 ~hppa ppc x86"

RDEPEND=">=dev-libs/boost-1.31.0
	media-libs/tiff
	media-libs/jpeg"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd $S
	sed -i -e "s:#include <iostream>:&\n#include <cerrno>\n:" \
		src/common.cpp || die

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc doc/{changes,copying,credits,notes,readme}
}
