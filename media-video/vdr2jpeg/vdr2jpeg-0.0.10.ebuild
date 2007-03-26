# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.0.10.ebuild,v 1.2 2007/03/26 20:38:22 zzam Exp $

inherit eutils

RESTRICT="strip"

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://www.deltab.de/vdr/vdr2jpeg.html"
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.4.9_p20061016"

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
