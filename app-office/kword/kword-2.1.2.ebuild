# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-2.1.2.ebuild,v 1.1 2010/03/31 21:53:38 tampakrap Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="wpd +wv2"

DEPEND="
	wpd? ( app-text/libwpd )
	wv2? ( >=app-text/wv2-0.4.2 )
"
RDEPEND="${DEPEND}"

KMEXTRA="filters/${KMMODULE}/"

KMEXTRACTONLY="
	filters/
	kspread/
	libs/
	plugins/
"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with wpd)
		$(cmake-utils_use_with wv2)"

	kde4-meta_src_configure
}
