# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/mp3ogg2wav/mp3ogg2wav-1.0.ebuild,v 1.1 2006/10/11 13:45:35 lack Exp $

ROX_LIB_VER=1.9.13
inherit rox

MY_PN="Mp3Ogg2Wav"
DESCRIPTION="Mp3Ogg2Wav: A small rox utility to convert .ogg and .mp3 files to .wav files."
HOMEPAGE="http://kymatica.com/software.html"
SRC_URI="http://kymatica.com/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-python/pyogg-1.3
		>=dev-python/pyvorbis-1.3
		>=dev-python/pymad-0.5.2"

APPNAME=${MY_PN}
S=${WORKDIR}
