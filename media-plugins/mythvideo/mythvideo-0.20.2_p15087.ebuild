# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.20.2_p15087.ebuild,v 1.3 2008/08/01 16:35:22 cardoe Exp $

inherit mythtv-plugins subversion

DESCRIPTION="Video player module for MythTV."
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	sys-apps/eject"
DEPEND="${RDEPEND}"

pkg_postinst() {
	elog "MythVideo can use any media player to playback files, since"
	elog "it's a setting in the setup menu."
	elog
	elog "MythTV also has an 'Internal' player you can use, which will"
	elog "be the default for new installs.  If you want to use it,"
	elog "set the player to 'Internal' (note spelling & caps)."
	elog
	elog "Otherwise, you can install mplayer, xine or any other video"
	elog "player and use that instead by configuring the player to use."
}
