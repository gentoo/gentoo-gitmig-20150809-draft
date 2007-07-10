# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-spider/vdr-spider-0.1.2.ebuild,v 1.2 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Spider patience game"
HOMEPAGE="http://toms-cafe.de/vdr/spider/"
SRC_URI="http://toms-cafe.de/vdr/spider/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.47"

SPIDER_DATA_DIR="/usr/share/vdr/spider"

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	sed -i spider.c -e 's:ConfigDirectory(Name()):"'${SPIDER_DATA_DIR}'":'
}

src_install() {
	vdr-plugin_src_install

	insinto ${SPIDER_DATA_DIR}
	doins ${S}/spider/*.xpm
}
