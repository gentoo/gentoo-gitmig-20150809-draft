# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qt-faststart/qt-faststart-0.2.ebuild,v 1.2 2008/12/31 03:38:49 mr_bones_ Exp $

inherit eutils

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
}

src_compile() {
	cd "${WORKDIR}/ffmpeg"
	./configure
	make qt-faststart
}

src_install() {
	install -D -m 755 -o root -g root "${WORKDIR}/ffmpeg/qt-faststart" "${D}/usr/bin/qt-faststart"
}
