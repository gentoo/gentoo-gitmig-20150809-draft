# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.16.ebuild,v 1.2 2004/12/05 01:00:00 iggy Exp $

inherit myth

DESCRIPTION="DVD player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="transcode debug nls"

DEPEND=">=sys-apps/sed-4
	>=media-plugins/mythvideo-${PV}*
	media-libs/libdvdread
	transcode? ( media-video/transcode )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_compile() {
	econf --enable-vcd `use_enable transcode` || die

	myth_src_compile || die
}
