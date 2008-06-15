# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-extrecmenu/vdr-extrecmenu-1.2_pre1.ebuild,v 1.3 2008/06/15 21:40:50 hd_brummy Exp $

inherit vdr-plugin eutils

MY_P="${PN}-${PV/_pre/-test}"

S=${WORKDIR}/${PN#vdr-}-1.2

DESCRIPTION="Video Disk Recorder - Extended recordings menu Plugin"
HOMEPAGE="http://martins-kabuff.de/extrecmenu.html"
SRC_URI="http://martins-kabuff.de/download/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"

src_unpack() {
	vdr-plugin_src_unpack

	epatch "${FILESDIR}/${P}-gcc43.patch"

	if grep -q fskProtection /usr/include/vdr/timers.h; then
		sed -i "s:#WITHPINPLUGIN:WITHPINPLUGIN:" Makefile
	fi
}
