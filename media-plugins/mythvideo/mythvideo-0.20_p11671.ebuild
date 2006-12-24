# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.20_p11671.ebuild,v 1.2 2006/12/24 08:07:27 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Video player module for MythTV."
IUSE="mplayer xine"
KEYWORDS="amd64 ppc x86"

RDEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	mplayer? ( || ( media-video/mplayer media-video/mplayer-bin ) )
	xine? ( media-video/xine-ui )"
DEPEND="${RDEPEND}"

pkg_postinst() {
	einfo "MythVideo can use any media player to playback files, since"
	einfo "it's a setting in the setup menu."
	einfo
	einfo "MythTv also has an 'Internal' player you can use, though"
	einfo "it will not support as many formats.  If you want to use it,"
	einfo "set the player to 'Internal' (note spelling & caps)."
}
