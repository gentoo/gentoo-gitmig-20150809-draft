# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.0.8b.ebuild,v 1.1 2006/04/24 09:03:17 hd_brummy Exp $

inherit eutils

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://www.deltab.de/vdr/vdr2jpeg.html"
SRC_URI="http://www.deltab.de/vdr/${P}.tgz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.4.9"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i "s:usr/local:usr:" Makefile

}

src_compile() {

	emake || die "emake failed"
}

src_install() {

	dobin vdr2jpeg
}
