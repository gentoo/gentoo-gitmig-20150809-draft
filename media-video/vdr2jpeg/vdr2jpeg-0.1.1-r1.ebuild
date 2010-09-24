# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.1.1-r1.ebuild,v 1.1 2010/09/24 10:02:06 hd_brummy Exp $

EAPI="2"

inherit eutils

RESTRICT="strip"

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://xxv.berlios.de/content/view/20/42/"
SRC_URI="mirror://berlios/xxv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_p20081014"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_prepare() {

	sed -e "s:usr/local:usr:" \
		-e "s:-o vdr2jpeg:\$(LDFLAGS) -o vdr2jpeg:" \
		-i Makefile
}

src_compile() {

	emake || die "emake failed"
}

src_install() {

	dobin vdr2jpeg || die "dobin failed"
}
