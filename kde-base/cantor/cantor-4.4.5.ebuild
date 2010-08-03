# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cantor/cantor-4.4.5.ebuild,v 1.2 2010/08/03 07:43:27 hwoarang Exp $

EAPI="3"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE4 interface for doing mathematics and scientific computing"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook ps +R"

# TODO Add Sage Mathematics Software backend (http://www.sagemath.org)
RDEPEND="
	ps? ( app-text/libspectre )
	R? ( dev-lang/R )
"
DEPEND="${RDEPEND}
	>=dev-cpp/eigen-2.0.3:2
"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with R)
	"

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! use R; then
		echo
		ewarn "You have decided to build ${PN} with no backend."
		ewarn "To have this application functional, please do one of below:"
		ewarn "    # emerge -va1 '='${CATEGORY}/${P} with 'R' USE flag enabled"
		ewarn "    # emerge -vaDu sci-mathematics/maxima"
		echo
	fi
}
