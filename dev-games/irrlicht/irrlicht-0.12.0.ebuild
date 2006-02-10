# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-0.12.0.ebuild,v 1.2 2006/02/10 16:13:28 wolf31o2 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/irrlicht/${P}.zip
	mirror://sourceforge/irrlicht/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	virtual/opengl
	|| (
		(
			virtual/glu
			x11-libs/libX11	)
		 virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	|| (
		(
			x11-proto/xproto
			x11-proto/xf86vidmodeproto )
		 virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"/source
	unzip -qo source.zip || die "unpacking source.zip"
	rm -f source.zip
	cd Irrlicht

	epatch "${FILESDIR}"/${PN}-0.12.0-64bit.patch

	# stupid nvidia / xorg GL differences
	if echo -e '#include <GL/glx.h>\nglXGetProcAddress blah;' | \
	   $(tc-getCC) -E - | \
	   grep -q glXGetProcAddressARB
	then
		epatch "${FILESDIR}"/${PN}-0.12.0-opengl.patch
	fi

	# use the system zlib/jpeg/png
	rm -r zlib jpeglib libpng
	sed -i -e 's:zlib.zlib\.h:zlib.h:' CZipReader.cpp || die "zlib sed"
	sed -i -e '/include/s:jpeglib/::'  CImageLoaderJPG.h || die "jpeg sed"
	sed -i -e '/include/s:libpng/::'   CImageLoaderPNG.cpp || die "png sed"
	sed -i -r \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e '/^LINKOBJ/s:(zlib|jpeglib|libpng)/[^.]+\.o::g' \
		Makefile || die "sed objs"
	for x in z jpeg png ; do
		mkdir ${x} && cd ${x} || die
		$(tc-getAR) x $($(tc-getCC) -print-file-name=lib${x}.a) || die "explode lib${x}.a"
		cd ..
	done
	sed -i \
		-e '/^LINKOBJ/s:$: $(wildcard z/*.o) $(wildcard jpeg/*.o) $(wildcard png/*.o):' \
		Makefile || die "sed objs two"
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
