# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sfftobmp/sfftobmp-3.0.ebuild,v 1.1 2004/11/15 17:54:24 lu_zero Exp $

MY_P=${PN}_${PV/./_}
S=${WORKDIR}/${MY_P}

DESCRIPTION="sff to bmp converter"
HOMEPAGE="http://sfftools.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfftools/${MY_P}_src.zip"

SLOT="0"
IUSE=""
LICENSE="as-is"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/libc
	>=dev-libs/boost-1.31.0
	media-libs/tiff
	media-libs/jpeg"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.59"

src_unpack() {
	unpack ${A}
	cd $S
	sed -i -e "s:#include <iostream>:&\n#include <cerrno>\n:" \
		src/common.cpp || die
}
src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/{changes,copying,credits,notes,readme}
}
