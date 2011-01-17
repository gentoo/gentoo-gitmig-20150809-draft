# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remote/vdr-remote-0.4.0-r2.ebuild,v 1.4 2011/01/17 21:50:00 hd_brummy Exp $

EAPI="2"

inherit linux-info vdr-plugin

DESCRIPTION="VDR Plugin: use various devices for controlling vdr (keyboards, lirc, remotes bundled with tv-cards)"
HOMEPAGE="http://www.escape-edv.de/endriss/vdr/"
SRC_URI="http://www.escape-edv.de/endriss/vdr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}"

src_prepare() {

	if kernel_is ge 2 6 34 ; then
		sed -i "${S}"/remote.c -e "/fh =/s:O_RDWR:O_WRONLY:"
	fi

	vdr-plugin_src_prepare
}
