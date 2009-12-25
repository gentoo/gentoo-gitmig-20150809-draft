# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/amanith/amanith-0.3-r2.ebuild,v 1.5 2009/12/25 18:14:57 yngwin Exp $

EAPI="1"
inherit eutils toolchain-funcs qt4

DESCRIPTION="OpenSource C++ CrossPlatform framework designed for 2d & 3d vector graphics"
HOMEPAGE="http://www.amanith.org/"
SRC_URI="http://www.amanith.org/download/files/${PN}_${PV//.}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples jpeg opengl png truetype"

DEPEND="
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( media-libs/glew )
	png? ( >=media-libs/libpng-1.2.10 )
	truetype? ( >=media-libs/freetype-2.2.1 )
	x11-libs/qt-gui:4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-freetype-fix.patch
	epatch "${FILESDIR}"/${P}-gcc-C++fix.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-nothirdpartystatic.patch
	epatch "${FILESDIR}"/${P}-system-freetype.patch
	epatch "${FILESDIR}"/${P}-system-glew.patch
	epatch "${FILESDIR}"/${P}-system-libjpeg.patch
	epatch "${FILESDIR}"/${P}-system-libpng.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch

	rm -rf 3rdpart include/GL || die
	sed -i -e '/SUBDIRS/s:3rdpart::' amanith.pro || die

	use_plugin() { use $1 || sed -i -e "/DEFINES.*_$2_PLUGIN/d" config/settings.conf ; }
	use_plugin jpeg JPEG
	use_plugin opengl OPENGLEXT
	use_plugin png PNG
	use_plugin truetype FONTS
	sed -i -e '/USE_QT4/s:#::' config/settings.conf || die
	sed -i -e '/SUBDIRS/s:examples::' amanith.pro || die
}

src_compile() {
	export AMANITHDIR="${S}"
	export LD_LIBRARY_PATH="${AMANITHDIR}/lib:${LD_LIBRARY_PATH}"

	eqmake4 || die
	emake || die
}

src_install() {
	dolib.so lib/*.so* || die
	if use jpeg || use png || use truetype ; then
		dolib.so plugins/*.so* || die
	fi

	insinto /usr/include
	doins -r include/amanith || die

	dodoc CHANGELOG FAQ README doc/amanith.chm

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples data config || die
	fi
}
