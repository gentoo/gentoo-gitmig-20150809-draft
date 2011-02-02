# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.72_beta1.ebuild,v 1.5 2011/02/02 04:22:46 tampakrap Exp $

EAPI=3

KDE_LINGUAS="cs de it nl pt_BR ru"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE4 based CDDA extraction tool."
HOMEPAGE="http://kde.maniatek.com/audex/"
SRC_URI="http://kde.maniatek.com/${PN}/files/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

PATCHES=(
	"${FILESDIR}/${P}-MkdirJob.patch"
	"${FILESDIR}/${P}-gcc45.patch"
)
