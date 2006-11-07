# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.20.ebuild,v 1.5 2006/11/07 14:23:39 beandog Exp $

inherit mythtv-plugins

DESCRIPTION="DVD player module for MythTV."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="transcode vcd"

RDEPEND="=media-plugins/mythvideo-${MY_PV}*
	transcode? ( 	media-video/transcode
			media-libs/libdvdread )"

MTVCONF="$(use_enable transcode)
	$(use_enable vcd)"

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
