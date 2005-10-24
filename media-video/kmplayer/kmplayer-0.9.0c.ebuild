# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.9.0c.ebuild,v 1.7 2005/10/24 16:30:40 dertobi123 Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://kmplayer.kde.org/pkgs/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="gstreamer mplayer xine"

# Removed koffice plugin, since the compilation fails and it's not supported upstream.
DEPEND="xine? ( >=media-libs/xine-lib-1_beta12 )
	gstreamer? ( >=media-libs/gst-plugins-0.8.7 )"
RDEPEND="mplayer? ( >=media-video/mplayer-0.90 )
	xine? ( >=media-libs/xine-lib-1_beta12 )
	gstreamer? ( >=media-libs/gst-plugins-0.8.7 )"
need-kde 3.1

pkg_setup() {
	if ! use mplayer && ! use xine ; then
		echo
		ewarn "Neither mplayer nor xine use flag is set. Either one is needed."
		ewarn "You can install mplayer later, though.\n"
	fi
}

src_compile(){
	local myconf="$(use_with gstreamer) $(use_with xine)"
	kde_src_compile
}
