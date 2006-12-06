# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-1.2.ebuild,v 1.1 2006/12/06 19:41:20 nyhm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/opengl
	virtual/glu
	x11-libs/libX11"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-proto/xproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${P}/source/Irrlicht

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}"/${P}
	edos2unix include/IrrCompileConfig.h
	epatch "${FILESDIR}"/${P}-config.patch

	cd "${S}"
	edos2unix ../../examples/Demo/Makefile
	epatch "${FILESDIR}"/${P}-demoMake.patch

	# stupid nvidia / xorg GL differences
	# still needed - bug #114335
	if echo -e '#include <GL/glx.h>\nglXGetProcAddress blah;' | \
	   $(tc-getCC) -E - | \
	   grep -q glXGetProcAddressARB
	then
		epatch "${FILESDIR}"/${PN}-0.12.0-opengl.patch
	fi

	# use the system zlib/jpeg/png
	sed -i \
		-e "/^CXX/s:g++:$(tc-getCXX):" \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e '/^CXXINCS/s:-Izlib -Ijpeglib -Ilibpng::' \
		-e '/^ZLIBOBJ/d' \
		-e '/^JPEGLIBOBJ/d' \
		-e '/^LIBPNGOBJ/d' \
		Makefile || die "sed failed"
}

src_install() {
	cd ../..
	dolib.a lib/Linux/libIrrlicht.a || die "dolib.a failed"
	insinto /usr/include/${PN}
	doins include/* || die "doins failed"
	dodoc changes.txt readme.txt
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r examples media || die "doins failed"
	fi
}
