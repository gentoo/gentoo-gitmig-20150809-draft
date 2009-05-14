# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavegain/wavegain-1.2.6.ebuild,v 1.2 2009/05/14 19:33:17 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="ReplayGain for WAVE audio files"
HOMEPAGE="http://www.rarewares.org/files/others"
SRC_URI="http://www.rarewares.org/files/others/${P}srcs.zip"
MY_P="${P/wavegain/WaveGain}"
S="${WORKDIR}/${MY_P}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="media-libs/libsndfile"
DEPEND="app-arch/unzip"

src_compile(){
	$(tc-getCC) ${CFLAGS} *.c -o wavegain -DHAVE_CONFIG_H -lm -lsndfile
}

src_install(){
	dobin wavegain
}
