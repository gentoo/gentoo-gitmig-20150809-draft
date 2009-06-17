# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audex/audex-0.71_beta3.ebuild,v 1.1 2009/06/17 21:59:04 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="cs de nl pt_BR"
inherit kde4-base

MY_PV=${PV/_beta/b}
DESCRIPTION="KDE4 based CDDA extraction tool."
HOMEPAGE="http://opensource.maniatek.de/cgi-bin/audex/audex/index.html"
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
