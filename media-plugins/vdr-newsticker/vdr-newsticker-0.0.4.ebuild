# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-newsticker/vdr-newsticker-0.0.4.ebuild,v 1.1 2006/03/20 17:03:12 zzam Exp $

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

src_install() {
	vdr-plugin_src_install

	keepdir /var/vdr/newsticker
	chown vdr:vdr ${D}/var/vdr/newsticker
}

