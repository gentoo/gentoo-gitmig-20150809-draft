# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-0.11.0.ebuild,v 1.1 2005/07/17 10:03:27 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/irrlicht/${P}.zip
	mirror://sourceforge/irrlicht/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	virtual/opengl
	virtual/x11"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"/source
	unzip -qo source.zip || die "unpacking source.zip"
	rm -f source.zip
	cd Irrlicht
	rm -r zlib jpeglib libpng
	sed -i -e 's:zlib.zlib\.h:zlib.h:' CZipReader.cpp || die "zlib sed"
	sed -i -e '/include/s:jpeglib/::'  CImageLoaderJPG.h || die "jpeg sed"
	sed -i -e '/include/s:libpng/::'   CImageLoaderPNG.cpp || die "png sed"
	sed -i -r \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e '/^LINKOBJ/s:(zlib|jpeglib|libpng)/[^.]+\.o::g' \
		Makefile || die "sed objs"

	# stupid nvidia / xorg GL differences
	if echo -e '#include <GL/glx.h>\nglXGetProcAddress blah;' | \
	   $(tc-getCC) -E - | \
	   grep -q glXGetProcAddressARB
	then
		epatch "${FILESDIR}"/${PN}-0.10.0-opengl.patch
	fi
}

src_compile() {
	emake -C source/Irrlicht || die "emake failed"
}

src_install() {
	dolib.a lib/Linux/libIrrlicht.a || die "dolib.a failed"
	insinto /usr/include/${PN}
	doins include/* || die "doins failed"
	dodoc changes.txt readme.txt
	if use doc ; then
		cp -r examples media "${D}"/usr/share/doc/${PF}/ || die "cp failed"
	fi
}
