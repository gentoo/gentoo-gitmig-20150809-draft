# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.20.ebuild,v 1.1 2006/09/14 05:38:04 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Video player module for MythTV."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	media-video/mplayer"
DEPEND="${RDEPEND}"
