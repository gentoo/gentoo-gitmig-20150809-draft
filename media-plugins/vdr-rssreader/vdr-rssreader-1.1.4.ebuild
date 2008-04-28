# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-rssreader/vdr-rssreader-1.1.4.ebuild,v 1.2 2008/04/28 09:09:00 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder RSS reader Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.7
		>=dev-libs/expat-1.95.8
		>=net-misc/curl-7.15.1-r1"

RDEPEND=""

PATCHES=("${FILESDIR}/${P}-gentoo.diff"
	"${FILESDIR}/${P}-gentoo-rss.diff")

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/rssreader
	doins "${S}/example/rssreader.conf"
}
