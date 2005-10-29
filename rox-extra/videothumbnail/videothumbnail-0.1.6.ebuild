# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/videothumbnail/videothumbnail-0.1.6.ebuild,v 1.1 2005/10/29 09:06:55 svyatogor Exp $

inherit rox

MY_PN="VideoThumbnail"
DESCRIPTION="This is a helper program for ROX-Filer. It provides images for video files. By Stephen Watson"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/VideoThumbnail.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="gnome"
KEYWORDS="~x86"

DEPEND="gnome? ( media-video/totem )
		!gnome? ( media-video/mplayer )"

ROX_VER="2.1.1"
ROX_LIB_VER="2.0.2"

APPNAME=${MY_PN}
S=${WORKDIR}

