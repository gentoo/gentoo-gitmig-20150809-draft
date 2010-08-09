# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qt-faststart/qt-faststart-0.2.ebuild,v 1.3 2010/08/09 23:48:29 hwoarang Exp $

inherit toolchain-funcs eutils

DESCRIPTION="qt-faststart rearranges quicktime files to help with better network streaming"
HOMEPAGE="http://svn.mplayerhq.hu/ffmpeg/trunk/tools/qt-faststart.c"
SRC_URI="mirror://gentoo/ffmpeg-0.4.9-p20070616.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/ffmpeg"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}.diff"  || die "patch failed"
	# add missing LDFLAGS
	sed -i "/qt-faststart/{n; s:\$(CFLAGS):& \$(LDFLAGS) :}" Makefile
}

src_compile() {
	cd "${WORKDIR}/ffmpeg"
	./configure --extra-ldflags="${LDFLAGS}" --extra-cflags="${CFLAGS}" \
		--cc=$(tc-getCC)
	make qt-faststart
}

src_install() {
	install -D -m 755 -o root -g root "${WORKDIR}/ffmpeg/qt-faststart" "${D}/usr/bin/qt-faststart"
}
