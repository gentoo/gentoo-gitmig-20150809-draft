# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavegain/wavegain-1.2.8.ebuild,v 1.1 2009/06/19 10:57:37 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="ReplayGain for WAVE audio files"
HOMEPAGE="http://www.rarewares.org/files/others"
SRC_URI="http://www.rarewares.org/files/others/${P}srcs.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsndfile"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P/wavegain/WaveGain}

src_compile(){
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} *.c -o ${PN} \
		-DHAVE_CONFIG_H -lm -lsndfile || die "build failed"
}

src_install(){
	dobin ${PN} || die "dobin failed"
}
