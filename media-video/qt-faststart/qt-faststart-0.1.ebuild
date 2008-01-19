# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qt-faststart/qt-faststart-0.1.ebuild,v 1.1 2008/01/19 17:09:43 caleb Exp $

DESCRIPTION="qt-faststart rearranges quicktime files to help with better network streaming"
HOMEPAGE="http://svn.mplayerhq.hu/ffmpeg/trunk/tools/qt-faststart.c"
SRC_URI="mirror://gentoo/ffmpeg-0.4.9-p20070616.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd "${WORKDIR}/ffmpeg"
	./configure
	make qt-faststart
}

src_install() {
	install -D -m 755 -o root -g root "${WORKDIR}/ffmpeg/qt-faststart" "${D}/usr/bin/qt-faststart"
}

