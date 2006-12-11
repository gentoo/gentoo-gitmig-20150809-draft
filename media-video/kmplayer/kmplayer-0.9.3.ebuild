# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.9.3.ebuild,v 1.9 2006/12/11 19:14:34 beandog Exp $

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend for KDE."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://kmplayer.kde.org/pkgs/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="gstreamer mplayer xine"

DEPEND="xine? ( >=media-libs/xine-lib-1.1.1 )
	gstreamer? ( || ( =media-libs/gst-plugins-base-0.10* =media-libs/gst-plugins-0.8* ) )
	x11-libs/libXv"

RDEPEND="mplayer? ( || ( media-video/mplayer media-video/mplayer-bin ) )
	xine? ( >=media-libs/xine-lib-1.1.1 )
	gstreamer? ( || ( =media-libs/gst-plugins-base-0.10* =media-libs/gst-plugins-0.8* ) )"

need-kde 3.5.4

pkg_setup() {
	if ! use mplayer && ! use xine && ! use gstreamer; then
		echo
		ewarn "Neither the mplayer, xine or gstreamer use flags have been set."
		ewarn "One is needed, you can install mplayer later, though.\n"
	fi
}

src_unpack() {
	kde_src_unpack

	if use mplayer && use amd64 && ! has_version media-video/mplayer; then
		#epatch "${FILESDIR}/${P}-use32bitbin.diff"
		einfo 'NOTICE: From this version the patch so that mplayer-bin is used'
		einfo 'NOTICE: instead of mplayer is applied no longer. Now you can'
		einfo 'NOTICE: configure kmplayer to use mplayer-bin from within the'
		einfo 'NOTICE: application.'
	fi
}


src_compile(){
	local myconf="$(use_with gstreamer) $(use_with xine)"
	kde_src_compile
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}/usr/share/mimelnk/application/x-mplayer2.desktop"
}
