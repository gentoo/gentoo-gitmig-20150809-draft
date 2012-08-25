# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/openofficeorg-thumbnail/openofficeorg-thumbnail-1.0.0-r1.ebuild,v 1.2 2012/08/25 19:46:43 creffett Exp $

EAPI=4

inherit kde4-base

MY_PN="OpenOfficeorgThumbnail"
MY_P="${MY_PN}"-"${PV}"
DESCRIPTION="KDE thumbnail-plugin that generates thumbnails for ODF files"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=110864"
SRC_URI="http://arielch.fedorapeople.org/devel/src/${MY_P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

S="${WORKDIR}"/"${MY_P}"

src_prepare() {
	sed -e "s:CacheThumbnail:X-CacheThumbnail:" \
		-e	"s:IgnoreMaximumSize:X-IgnoreMaximumSize:" \
		-i	src/openofficeorgthumbnail.desktop || die "fixing .desktop file	failed"
	kde4-base_src_prepare
}
