# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-svdrpservice/vdr-svdrpservice-0.0.3.ebuild,v 1.1 2007/10/07 11:10:38 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR: svdrpservice PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/svdrpservice/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"

src_install() {
	vdr-plugin_src_install

	insinto /usr/include/svdrpservice
	doins svdrpservice.h
}
