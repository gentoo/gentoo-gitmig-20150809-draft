# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/music-box/music-box-0.0.17.ebuild,v 1.1 2004/12/08 19:24:54 sergey Exp $

DESCRIPTION="MusicBox - an MP3/OGG Player for the ROX Desktop"

HOMEPAGE="http://khayber.dyndns.org/rox/"

SRC_URI="http://khayber.dyndns.org/rox/musicbox/MusicBox-017.1.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="oggvorbis"

DEPEND=">=dev-python/pymad-0.4.1
	 >=dev-python/pyao-0.8.1
	 oggvorbis? (
		 >=dev-python/pyvorbis-1.1
		 >=dev-python/pyogg-1.1
		 >=media-libs/libogg-1.0
		 >=media-libs/libvorbis-1.0-r2 )
	 >=media-libs/libmad-0.15.0b-r1
	 >=media-libs/libao-0.8.3-r1
	 >=dev-python/pyid3lib-0.5.1"

ROX_LIB_VER=1.9.14

APPNAME=MusicBox

S=${WORKDIR}

inherit rox
