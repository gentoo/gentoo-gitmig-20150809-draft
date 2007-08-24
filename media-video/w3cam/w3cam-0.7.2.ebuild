# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/w3cam/w3cam-0.7.2.ebuild,v 1.12 2007/08/24 07:29:09 vapier Exp $

#
# You can set the default device that vidcat and w3camd use by setting
# the environment variable W3CAM_DEVCE when emerging.
# eg.
#
# W3CAM_DEVICE="/dev/video0" emerge w3cam
#

DESCRIPTION="set of small programs to grab images and videos from video4linux devices"
HOMEPAGE="http://mpx.freeshell.org/"
SRC_URI="http://mpx.freeshell.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="truetype"

DEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	truetype? ( media-libs/freetype )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/-lpthread/s:$: $(LDFLAGS):' w3camd/Makefile.in
}

src_compile() {
	local myconf
	use truetype && \
		myconf="${myconf} --with-ttf-inc=/usr/include/freetype"

	econf \
		--with-device=${W3CAM_DEVICE:-/dev/video0} \
		${myconf} \
		|| die "econf failed"
	emake || die
}

src_install() {
	dobin vidcat w3camd/w3camd || die
	doman vidcat.1
	dodoc ChangeLog.txt FAQ.txt README SAMPLES TODO.txt \
		index.html w3cam.css w3cam.cgi w3cam.cgi.scf
	docinto samples
	dodoc samples/*
	docinto w3camd
	dodoc w3camd/README w3camd/index.html w3camd/test.html w3camd/w3camd.fig
}
