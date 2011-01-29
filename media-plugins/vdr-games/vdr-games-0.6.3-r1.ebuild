# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-games/vdr-games-0.6.3-r1.ebuild,v 1.1 2011/01/29 01:03:17 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder games plugin"
HOMEPAGE="http://1541.org/"
SRC_URI="http://1541.org/public/${P}.tar.gz
	mirror://vdrfiles/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gentoo.diff" )

src_prepare() {
	vdr-plugin_src_prepare

	sed -i Makefile -e "s:make -s:\$(MAKE) -s:g"
}
