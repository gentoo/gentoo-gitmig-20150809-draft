# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.20_p11329.ebuild,v 1.1 2006/09/29 14:30:37 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="DVD player module for MythTV."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="transcode"

RDEPEND="=media-plugins/mythvideo-${MY_PV}*
	transcode? ( 	media-video/transcode
			media-libs/libdvdread )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )"

MTVCONF="--enable-vcd $(use_enable transcode)"

src_install() {
	mythtv-plugins_src_install

	newinitd "${FILESDIR}"/mtd.init mtd
}

pkg_postinst() {
	echo
	einfo "To have Myth Transcode Daemon (mtd) start on boot do the following"
	einfo "rc-update add mtd default"
	einfo "Make sure you run 'mtd -n' to setup mtd first"
	echo
}
