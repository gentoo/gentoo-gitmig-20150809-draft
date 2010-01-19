# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klinkstatus/klinkstatus-4.3.3.ebuild,v 1.6 2010/01/19 02:59:24 jer Exp $

EAPI="2"
KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="KDE web development - link validity checker"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug +handbook tidy"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_KdepimLibs=ON
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "To use scripting in ${PN}, install dev-lang/ruby."
	echo
}
