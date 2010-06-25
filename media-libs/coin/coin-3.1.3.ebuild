# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-3.1.3.ebuild,v 1.1 2010/06/25 20:26:39 reavertm Exp $

EAPI=2

inherit eutils base flag-o-matic

MY_P=${P/c/C}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A high-level 3D graphics toolkit, fully compatible with SGI Open Inventor 2.1."
HOMEPAGE="http://www.coin3d.org/"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/all/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="debug doc javascript openal static-libs threads"

RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype:2
	sys-libs/zlib
	virtual/opengl
	virtual/glu
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	javascript? ( dev-lang/spidermonkey )
	openal? ( media-libs/openal )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	doc? ( app-doc/doxygen )
"

DOCS=(
	AUTHORS FAQ FAQ.legal NEWS README RELNOTES THANKS
	docs/{ChangeLog.v${PV},HACKING,oiki-launch.txt}
)

PATCHES=(
	"${FILESDIR}/${PN}-3.1.0-javascript.patch"
)

src_configure() {
	MANDIR=/usr/share/Coin/man
	append-cppflags -I/usr/include/freetype2
	# Prefer link-time linking over dlopen
	econf \
		htmldir="/usr/share/doc/${PF}/html" \
		--disable-dl-fontconfig \
		--disable-dl-freetype \
		--disable-dl-libbzip2 \
		--disable-dl-openal \
		--disable-dl-zlib \
		--disable-dyld \
		--disable-loadlibrary \
		--disable-java-wrapper \
		--enable-3ds-import \
		--enable-compact \
		--enable-dl-glu \
		--enable-dl-spidermonkey \
		--enable-system-expat \
		--includedir="/usr/include/${PN}" \
		--mandir="${MANDIR}" \
		--with-fontconfig \
		--with-freetype \
		$(use_enable debug) \
		$(use_enable debug symbols) \
		$(use_enable doc html) \
		$(use_enable doc man) \
		$(use_enable javascript javascript-api) \
		$(use_enable openal sound) \
		$(use_enable static-libs static) \
		$(use_enable threads threadsafe) \
		$(use_with javascript spidermonkey) \
		$(use_with openal)
}

src_install() {
	base_src_install

	if use doc; then
		cat >"${T}/50coin" <<-__EOF__
MANPATH=${MANDIR}
__EOF__
		doenvd "${T}/50coin"
	fi

	# Remove libtool files when not needed.
	use static-libs || rm -f "${D}"/usr/lib*/*.la
}
