# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/w3cam/w3cam-0.7.2.ebuild,v 1.11 2006/03/07 17:21:07 flameeyes Exp $

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
KEYWORDS="~ppc x86"
IUSE="truetype"

DEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	truetype? ( media-libs/freetype )"

src_compile() {
	local myconf

	[[ -n "${W3CAM_DEVICE}" ]] && \
		myconf="${myconf} --with-device=${W3CAM_DEVICE}"

	use truetype && \
		myconf="${myconf} --with-ttf-inc=/usr/include/freetype"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin vidcat w3camd/w3camd
	doman vidcat.1
	dodoc ChangeLog.txt FAQ.txt README SAMPLES TODO.txt \
		index.html w3cam.css w3cam.cgi w3cam.cgi.scf
	docinto samples
	dodoc samples/*
	docinto w3camd
	dodoc w3camd/README w3camd/index.html w3camd/test.html w3camd/w3camd.fig
}
