# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.22_p22864.ebuild,v 1.1 2009/11/21 05:28:37 cardoe Exp $

EAPI=2

inherit qt4 mythtv-plugins

DESCRIPTION="Video player module for MythTV."
IUSE="+jamu"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	sys-apps/eject
	dev-python/imdbpy"
DEPEND=""

src_install() {
	mythtv-plugins_src_install

	newinitd "${FILESDIR}"/mtd.init.d mtd

	# correct permissions so MythVideo is actually usable
	fperms 755 /usr/share/mythtv/mythvideo/scripts/*.pl
	fperms 755 /usr/share/mythtv/mythvideo/scripts/*.py

	# setup JAMU cron jobs
	if use jamu; then
		exeinto /etc/cron.daily
		newexe "${FILESDIR}/mythvideo.daily" mythvideo
		exeinto /etc/cron.hourly
		newexe "${FILESDIR}/mythvideo.hourly" mythvideo
		exeinto /etc/cron.weekly
		newexe "${FILESDIR}/mythvideo.weekly" mythvideo
	fi
}

pkg_postinst() {
	elog "MythVideo can use any media player to playback files if you"
	elog "are *NOT* using Storage Groups. If you are using Storage"
	elog "Groups, you *MUST* use the Internal player."
	elog
	elog "Otherwise, you can install mplayer, xine or any other video"
	elog "player and use that instead by configuring the player to use."
	elog "The default is 'Internal'."
}
