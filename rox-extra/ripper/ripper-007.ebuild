# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/ripper/ripper-007.ebuild,v 1.1 2006/10/30 17:40:11 lack Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Ripper"
DESCRIPTION="Ripper - A MP3/OGG ripper/encoder for the ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/desktop/Software/Audio_Video/Ripper"
SRC_URI="http://www.hayber.us/rox/ripper/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mp3 ogg cdparanoia"

RDEPEND="
	app-cdr/cdrtools
	cdparanoia? ( media-sound/cdparanoia )
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )"

APPNAME=${MY_PN}
S=${WORKDIR}
