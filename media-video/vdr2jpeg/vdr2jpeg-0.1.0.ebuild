# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.1.0.ebuild,v 1.4 2008/05/02 21:23:25 hd_brummy Exp $

inherit eutils

RESTRICT="strip"

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://xxv.berlios.de/content/view/27/42/"
SRC_URI="mirror://berlios/xxv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_p20080326"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	cd "${S}"
	sed -i "s:usr/local:usr:" Makefile

	epatch "${FILESDIR}/ffmpeg-0.4.9_p20080326-new_header.diff"
}

src_compile() {

	emake || die "emake failed"
}

src_install() {

	dobin vdr2jpeg || die "dobin failed"
}
