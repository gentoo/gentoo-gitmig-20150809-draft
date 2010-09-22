# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vodcatcher/vdr-vodcatcher-0.2.2.ebuild,v 1.1 2010/09/22 20:56:05 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Downloads rss-feeds and passes video enclosures to the mplayer plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-vodcatcher"
SRC_URI="http://projects.vdr-developer.org/attachments/download/154/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
		>=dev-libs/tinyxml-2.6.1
		media-video/vdr
		|| ( media-plugins/vdr-mplayer media-plugins/vdr-xineliboutput )"

PATCHES=( "${FILESDIR}/${P}_unbundle-tinyxml2.diff" )

src_prepare() {
	vdr-plugin_src_prepare

	sed -e "s:ConfigDirectory():ConfigDirectory( \"vodcatcher\" ):" -i src/VodcatcherPlugin.cc
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/vodcatcher/
	doins   examples/vodcatchersources.conf

	diropts -gvdr -ovdr
	keepdir /var/cache/vdr-plugin-vodcatcher
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "! IMPORTEND"
	elog "In order to allow the MPlayer plug-in to play back the streams passed in by the"
	elog "Vodcatcher, you must add the following entry to the mplayersources.conf file:"
	echo
	elog "/tmp;Vodcatcher;0"
	echo
}
