# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-newsticker/vdr-newsticker-0.0.4.ebuild,v 1.2 2006/07/08 18:55:57 zzam Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Show rdf Newsticker on TV"
HOMEPAGE="http://www.wontorra.net"
SRC_URI="http://www.wontorra.net/filemgmt_data/files/${P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6
	net-misc/wget"

PATCHES="${FILESDIR}/${P}-gcc4.diff"

src_install() {
	vdr-plugin_src_install

	keepdir /var/vdr/newsticker
	chown vdr:vdr ${D}/var/vdr/newsticker
}

