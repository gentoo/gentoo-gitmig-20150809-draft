# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.0.12.ebuild,v 1.2 2008/01/13 19:35:13 hd_brummy Exp $

inherit eutils

RESTRICT="strip"

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://xxv.berlios.de/content/view/27/42/"
SRC_URI="http://download.berlios.de/xxv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.4.9_p20070616
		dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	cd "${S}"
	sed -i "s:usr/local:usr:" Makefile

}

src_compile() {

	emake || die "emake failed"
}

src_install() {

	dobin vdr2jpeg
}
