# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/fresco-base/fresco/fresco-20020808.ebuild,v 1.4 2004/06/24 21:50:48 agriffis Exp $

MY_PN="${PN/fresco/Fresco}"
S="${WORKDIR}/${MY_PN}"
DESCRIPTION="fresco -- A free X11 replacement which is under heavy development"
HOMEPAGE="http://www2.fresco.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
	
DEPEND=">=net-misc/omniORB-305
	media-libs/libggi
	media-libs/libsdl
	dev-libs/DirectFB
	virtual/opengl
	media-libs/libart_lgpl
	>=media-libs/freetype-2.0.0
	sys-libs/zlib
	media-libs/libpng
	fresco-base/fresco-env"


src_compile() {
	./autogen.sh || die "autogen.sh failed"
	./configure || die "configure failed" 
	make configure_args="--prefix=/opt/fresco --enable-tracer" || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
}
