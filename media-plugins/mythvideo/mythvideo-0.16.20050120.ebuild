# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.16.20050120.ebuild,v 1.1 2005/01/20 08:29:40 cardoe Exp $

inherit myth eutils

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S=${WORKDIR}/mythvideo

DEPEND=">=sys-apps/sed-4
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	|| ( media-video/mplayer media-video/xine-ui )
	|| ( ~media-tv/mythtv-0.16.20050115 ~media-tv/mythfrontend-0.16.20050115 )"

setup_pro() {
	return 0
}
