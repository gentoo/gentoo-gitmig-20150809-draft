# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/w3cam/w3cam-0.7.2.ebuild,v 1.4 2003/07/12 21:12:57 aliz Exp $

#
# You can set the default device that vidcat and w3camd use by setting
# the environment variable W3CAM_DEVCE when emerging.
# eg.
#
# W3CAM_DEVICE="/dev/video0" emerge w3cam
#

IUSE="truetype"

S=${WORKDIR}/${P}
DESCRIPTION="w3cam - a set of small programs to grab images and videos from video4linux devices"
HOMEPAGE="http://mpx.freeshell.org/"
SRC_URI="http://mpx.freeshell.org/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="virtual/glibc \
	sys-libs/zlib \
	media-libs/jpeg \
	media-libs/libpng \
	truetype? ( media-libs/freetype )"

src_compile() {
	local myconf

	test -n "${W3CAM_DEVICE}" && \
		myconf="${myconf} --with-device=${W3CAM_DEVICE}"

	use truetype && \
		myconf="${myconf} --with-ttf-inc=/usr/include/freetype"
	
	./configure \
	    --host=${CHOST} \
	    --prefix=/usr \
	    --mandir=/usr/share/man/man1 \
	    ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	dobin vidcat w3camd/w3camd
	doman vidcat.1
	dodoc COPYING.txt ChangeLog.txt FAQ.txt README SAMPLES TODO.txt \
	    index.html w3cam.css w3cam.cgi w3cam.cgi.scf
	docinto samples
	dodoc samples/*
	docinto w3camd
	dodoc w3camd/README w3camd/index.html w3camd/test.html w3camd/w3camd.fig
}

