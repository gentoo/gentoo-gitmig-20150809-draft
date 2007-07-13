# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spcaview/spcaview-20061208.ebuild,v 1.2 2007/07/13 22:04:15 vapier Exp $

inherit eutils

DESCRIPTION="A webcam viewer for the spca5xx driver"
HOMEPAGE="http://mxhaard.free.fr/sview.html"
SRC_URI="http://mxhaard.free.fr/spca50x/Download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv server.c spcaserv.c
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i '/^BIN/s:/local::' Makefile
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README Changelog
}
