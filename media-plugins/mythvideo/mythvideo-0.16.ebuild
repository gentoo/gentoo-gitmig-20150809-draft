# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.16.ebuild,v 1.3 2004/12/05 00:59:00 iggy Exp $

inherit myth eutils

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE="debug nls"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	dev-perl/XML-Simple
	|| ( media-video/mplayer media-video/xine-ui )
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_unpack() {
	myth_src_unpack || die

	epatch ${FILESDIR}/${P}-gcc34.patch
}
