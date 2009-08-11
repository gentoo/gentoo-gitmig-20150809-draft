# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vodcatcher/vdr-vodcatcher-0.2.1.ebuild,v 1.2 2009/08/11 09:26:12 ssuominen Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Downloads rss-feeds and passes video enclosures to the mplayer plugin"
HOMEPAGE="http://www.e-tobi.net/blog/pages/vdr-vodcatcher"
SRC_URI="http://www.e-tobi.net/blog/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
		media-video/vdr
		|| ( media-plugins/vdr-mplayer media-plugins/vdr-xineliboutput )"

PATCHES=( "${FILESDIR}/${P}-gcc44.patch" )

src_unpack() {
	vdr-plugin_src_unpack

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
