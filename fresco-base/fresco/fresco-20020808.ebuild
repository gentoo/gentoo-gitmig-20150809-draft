# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/fresco-base/fresco/fresco-20020808.ebuild,v 1.1 2002/08/12 16:28:56 phoenix Exp $

MY_PN="${PN/fresco/Fresco}"
S="${WORKDIR}/${MY_PN}"
DESCRIPTION="fresco -- A free X11 replacement which is under heavy development"
HOMEPAGE="http://www2.fresco.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="fresco"
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
