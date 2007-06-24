# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/ripper/ripper-007-r1.ebuild,v 1.3 2007/06/24 17:20:21 lack Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Ripper"
DESCRIPTION="Ripper - A MP3/OGG ripper/encoder for the ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/desktop/Software/Audio_Video/Ripper"
SRC_URI="http://www.hayber.us/rox/ripper/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="mp3 ogg cdparanoia"

RDEPEND="
	virtual/cdrtools
	cdparanoia? ( media-sound/cdparanoia )
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )"

APPNAME=${MY_PN}
APPCATEGORY="AudioVideo;DiscBurning"
S=${WORKDIR}
