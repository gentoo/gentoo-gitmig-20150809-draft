# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sysinfo/vdr-sysinfo-0.1.0a.ebuild,v 1.1 2006/05/01 12:32:07 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Shows information over your system (CPU/Memory usage ...)"
HOMEPAGE="http://kikko77.altervista.org/"
SRC_URI="http://kikko77.altervista.org/sections/Download/[12]_sysinfo/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	sed -e "s-sysinfo.sh-/usr/share/vdr/sysinfo/sysinfo.sh-" -i sysinfoosd.c
}

src_install() {
	vdr-plugin_src_install
	insinto /usr/share/vdr/sysinfo/
	insopts -m0755
	doins script/sysinfo.sh
}
