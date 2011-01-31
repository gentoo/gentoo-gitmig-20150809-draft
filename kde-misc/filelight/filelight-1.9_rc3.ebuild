# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.9_rc3.ebuild,v 1.10 2011/01/31 03:16:42 tampakrap Exp $

EAPI=3
KMNAME="playground/utils"

inherit kde4-base

MY_P=${P/_}

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."
HOMEPAGE="http://kde-apps.org/content/show.php/filelight?content=99561"
SRC_URI="http://kde-apps.org/CONTENT/content-files/99561-${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}/${P}-gcc45.patch" )

src_prepare() {
	sed -i \
		-e '/qimageblitz/d' \
		src/part/radialMap/map.cpp || die #307823

	kde4-base_src_prepare
}
