# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.19_pre8642.ebuild,v 1.1 2006/01/22 07:52:26 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="DVD player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="mirror://gentoo/mythplugins-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="transcode"

RDEPEND="~media-tv/mythtv-${PV}
	~media-plugins/mythvideo-${PV}
	transcode? ( 	media-video/transcode
			media-libs/libdvdread )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )"

S=${WORKDIR}/mythplugins

MTVCONF="--enable-vcd $(use_enable transcode)"
