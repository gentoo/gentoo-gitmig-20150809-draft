# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.72_beta1.ebuild,v 1.1 2009/09/13 09:40:27 tgurr Exp $

EAPI="2"

KDE_LINGUAS="cs de it nl pt_BR ru"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE4 based CDDA extraction tool."
HOMEPAGE="http://opensource.maniatek.de/audex/"
SRC_URI="http://opensource.maniatek.de/${PN}/files/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/libkcddb-${KDE_MINIMAL}
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	media-sound/cdparanoia"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
