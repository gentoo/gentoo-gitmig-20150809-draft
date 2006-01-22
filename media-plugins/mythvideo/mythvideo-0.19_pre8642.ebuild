# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.19_pre8642.ebuild,v 1.1 2006/01/22 07:51:32 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="mirror://gentoo/mythplugins-${PV}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	~media-tv/mythtv-${PV}
	media-video/mplayer"
