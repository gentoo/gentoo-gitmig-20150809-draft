# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-3.1.ebuild,v 1.8 2012/03/12 16:02:12 ranger Exp $

EAPI="3"

inherit base prefix qt4-r2 versionator

# The upstream version numbering is bad, so we have to remove a dot in the
# minor version number
MAJOR="$(get_major_version)"
MINOR_1="$(($(get_version_component_range 2)/10))"
MINOR_2="$(($(get_version_component_range 2)%10))"
if [ ${MINOR_2} -eq "0" ] ; then
	MY_P="${PN}-${MAJOR}.${MINOR_1}"
else
	MY_P="${PN}-${MAJOR}.${MINOR_1}.${MINOR_2}"
fi

MY_P="${P}"

DESCRIPTION="A nice LaTeX-IDE"
HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

COMMON_DEPEND="
	app-text/poppler[qt4]
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/qt-gui-4.6.1:4
	>=x11-libs/qt-core-4.6.1:4
	>=x11-libs/qt-webkit-4.6.1:4
	>=app-text/hunspell-1.2.4"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-hunspell.patch" )

src_prepare() {
	qt4-r2_src_prepare
	eprefixify ${PN}.pro configdialog.cpp
}

src_install() {
	emake INSTALL_ROOT="${ED}" install || die "make install failed"

	insinto /usr/share/pixmaps/texmaker
	doins utilities/texmaker*.png || die "doins failed."
	doins utilities/texmaker.svg || die "doins failed."

	dodoc utilities/AUTHORS utilities/CHANGELOG.txt || die "dodoc failed"
}

pkg_postinst() {
	elog "A user manual with many screenshots is available at:"
	elog "${EPREFIX}/usr/share/${PN}/usermanual_en.html"
}
