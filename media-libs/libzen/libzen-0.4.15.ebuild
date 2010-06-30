# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libzen/libzen-0.4.15.ebuild,v 1.2 2010/06/30 06:47:06 fauli Exp $

EAPI="2"
WX_GTK_VER="2.8"

inherit autotools wxwidgets multilib

MY_PN="ZenLib"
DESCRIPTION="Shared library for libmediainfo and medianfo-gui"
HOMEPAGE="http://sourceforge.net/projects/zenlib"
SRC_URI="mirror://sourceforge/zenlib/${MY_PN}%20-%20Sources/${PV}/${PN}_${PV}.tar.bz2"

S="${WORKDIR}/${MY_PN}/Project/GNU/Library"

LICENSE="as-is ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc static-libs wxwidgets"

RDEPEND="sys-libs/zlib
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		--enable-unicode \
		$(use_enable debug) \
		$(use_with wxwidgets) \
		$(use_with wxwidgets wx-gui) \
		$(use_enable static-libs static)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${WORKDIR}/${MY_PN}/Source/Doc"
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	einstall

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${PN}.pc" || die

	for x in ./ Base64 Format/Html Format/Http HTTP_Client TinyXml; do
		insinto "/usr/include/${MY_PN}/${x}"
		doins "${WORKDIR}/${MY_PN}/Source/${MY_PN}/${x}/"*.h || die
	done

	dodoc "${WORKDIR}/${MY_PN}/"*.txt
	if use doc; then
		dohtml "${WORKDIR}/${MY_PN}/Source/Doc/Documentation.html" || die
		dohtml -r "${WORKDIR}/${MY_PN}/Doc" || die
	fi
}
