# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-2.3.3-r1.ebuild,v 1.3 2011/10/20 20:17:17 dilfridge Exp $

EAPI=3

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice word processor"

KEYWORDS="~amd64 ~x86"
IUSE="wpd"

SRC_URI+=" http://dev.gentoo.org/~dilfridge/distfiles/kword-2.3.3-libwpg02.patch.bz2"

DEPEND="
	gnome-extra/libgsf
	wpd? ( app-text/libwpd )
"
RDEPEND="${DEPEND}
	!app-text/wv2
"

PATCHES=( "${DISTDIR}/${PN}-2.3.3-libwpg02.patch.bz2" )

KMEXTRA="filters/${KMMODULE}/
	filters/libmso/
"

KMEXTRACTONLY="
	KoConfig.h.cmake
	filters/
	kspread/
	libs/
	plugins/
"

KMLOADLIBS="koffice-libs"

RESTRICT="test"
# bug 387791

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with wpd)
		-DWITH_DCMTK=OFF
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
