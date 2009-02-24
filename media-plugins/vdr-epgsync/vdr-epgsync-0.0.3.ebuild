# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsync/vdr-epgsync-0.0.3.ebuild,v 1.1 2009/02/24 17:51:51 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Import the EPG of another VDR via vdr-svdrpservice"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/epgsync/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

PATCHES=("${FILESDIR}/${P}-Makefile.diff")

DEPEND=(">=media-video/vdr-1.4.0"
	">=media-plugins/vdr-svdrpservice-0.0.2")

src_unpack() {
	vdr-plugin_src_unpack unpack

	cd "${S}"
	sed -i thread.h \
		-e 's-../svdrpservice/svdrpservice.h-svdrpservice/svdrpservice.h-'

	vdr-plugin_src_unpack all_but_unpack
}

