# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/videothumbnail/videothumbnail-0.1.12.ebuild,v 1.1 2006/04/16 12:52:35 svyatogor Exp $


MY_PN="VideoThumbnail"
DESCRIPTION="This is a helper program for ROX-Filer. It provides images for video files. By Stephen Watson"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/VideoThumbnail.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=media-video/mplayer-0.9.0"

#Setting ROX_VER to 2.3 to be on safe side. See bug #112849
ROX_VER="2.3"
ROX_LIB_VER="2.0.2"

APPNAME=${MY_PN}
S=${WORKDIR}

inherit rox
