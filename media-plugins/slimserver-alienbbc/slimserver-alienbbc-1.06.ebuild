# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/slimserver-alienbbc/slimserver-alienbbc-1.06.ebuild,v 1.1 2006/11/13 19:58:25 twp Exp $

inherit eutils

SLIMSERVER_VERSION="6.5"
MY_P="alienbbc-linux-v${PV}_${SLIMSERVER_VERSION}"
DESCRIPTION="A plugin for SlimServer for listening to RealAudio streams"
HOMEPAGE="http://www.x2systems.com/AlienBBC/"
SRC_URI="http://www.x2systems.com/AlienBBC/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="
	>=media-sound/slimserver-${SLIMSERVER_VERSION}
	>=media-video/mplayer-1.0_pre7"
S="${WORKDIR}"

pkg_preinst() {
	if ! built_with_use media-video/mplayer live; then
		eerror "media-video/mplayer not built with USE=live"
		die "media-video/mplayer not built with USE=live"
	fi
	# FIXME does mplayer need to be built with USE=real?
}

src_install() {
	dodir /opt/slimserver/.mplayer
	touch ${D}/opt/slimserver/.mplayer/.config
	cp -r * ${D}/opt/slimserver
}
