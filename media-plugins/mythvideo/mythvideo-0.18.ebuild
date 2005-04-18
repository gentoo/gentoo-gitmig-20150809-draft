# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.18.ebuild,v 1.1 2005/04/18 07:55:57 eradicator Exp $

inherit myth eutils

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

RDEPEND="${DEPEND}
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser
	 dev-perl/URI
	 dev-perl/XML-Simple
	 || ( media-video/mplayer media-video/xine-ui )"

setup_pro() {
	return 0
}
