# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kpresenter/kpresenter-2.3.3.ebuild,v 1.2 2011/05/09 08:33:54 tomka Exp $

EAPI=3

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice presentation program"

KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	KoConfig.h.cmake
	filters/libmsooxml/
	filters/kspread/xlsx/
	libs/
"
KMEXTRA="
	filters/${KMMODULE}/
	filters/libmso/
"

KMLOADLIBS="koffice-libs"

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
