# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.22_p22991.ebuild,v 1.2 2011/03/31 15:24:13 ssuominen Exp $

EAPI=2

inherit qt4 mythtv-plugins

DESCRIPTION="Video player module for MythTV."
IUSE="+jamu"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	virtual/eject
	jamu? ( >=dev-python/imdbpy-3.8
			>=dev-python/mysql-python-1.2.2
			media-tv/mythtv[python] )"
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
		newexe "${FILESDIR}/mythvideo.daily" mythvideo || die
		exeinto /etc/cron.hourly
		newexe "${FILESDIR}/mythvideo.hourly" mythvideo || die
		exeinto /etc/cron.weekly
		newexe "${FILESDIR}/mythvideo.weekly" mythvideo || die
		insinto /home/mythtv/.mythtv/
		newins mythvideo/scripts/jamu-example.conf jamu.conf || die
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
