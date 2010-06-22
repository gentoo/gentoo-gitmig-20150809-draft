# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.72_beta1.ebuild,v 1.4 2010/06/22 18:19:45 hwoarang Exp $

EAPI="2"

KDE_LINGUAS="cs de it nl pt_BR ru"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE4 based CDDA extraction tool."
HOMEPAGE="http://kde.maniatek.com/audex/"
SRC_URI="http://kde.maniatek.com/${PN}/files/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/libkcddb-${KDE_MINIMAL}
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	media-sound/cdparanoia"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

PATCHES=(
	"${FILESDIR}/${P}-MkdirJob.patch"
	"${FILESDIR}/${P}-gcc45.patch"
)
