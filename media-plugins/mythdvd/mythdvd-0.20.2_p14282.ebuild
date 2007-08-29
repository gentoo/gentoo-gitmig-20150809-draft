# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.20.2_p14282.ebuild,v 1.3 2007/08/29 18:28:41 cardoe Exp $

inherit mythtv-plugins subversion

DESCRIPTION="DVD player module for MythTV."
KEYWORDS="amd64 ppc x86"
IUSE="transcode vcd"

RDEPEND="=media-plugins/mythvideo-${MY_PV}*
	transcode? ( media-video/transcode
				media-libs/libdvdread )
	sys-apps/eject"

MTVCONF="$(use_enable transcode)
	$(use_enable vcd)"

src_install() {
	mythtv-plugins_src_install

	newinitd "${FILESDIR}"/mtd.init mtd
}

pkg_postinst() {
	echo
	elog "To have Myth Transcode Daemon (mtd) start on boot do the following"
	elog "rc-update add mtd default"
	elog "Make sure you run 'mtd -n' to setup mtd first"
	echo
}
