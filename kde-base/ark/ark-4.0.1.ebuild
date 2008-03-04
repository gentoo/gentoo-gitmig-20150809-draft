# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-4.0.1.ebuild,v 1.3 2008/03/04 01:51:36 jer Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE Archiving tool"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="archive debug htmlhandbook zip"

DEPEND="archive? ( app-arch/libarchive )
	zip? ( >=dev-libs/libzip-0.8 )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with zip LibZip)"

	kde4-meta_src_compile
}
