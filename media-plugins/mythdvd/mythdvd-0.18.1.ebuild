# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.18.1.ebuild,v 1.1 2005/05/20 09:04:38 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="DVD player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="transcode"

RDEPEND=">=media-plugins/mythvideo-${PV}
	media-libs/libdvdread
	~media-tv/mythtv-${PV}
	transcode? ( media-video/transcode )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )"

MTVCONF="--enable-vcd $(use_enable transcode)"
