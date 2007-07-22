# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuppelvideo/nuppelvideo-0.53a.ebuild,v 1.3 2007/07/22 09:06:38 dberkholz Exp $

inherit eutils toolchain-funcs linux-info

DESCRIPTION="NuppelVideo is a simple low consuming and fast capture program for bttv-cards (BT8x8)"
HOMEPAGE="http://www.linux.org/apps/AppId_6998.html"
SRC_URI="mirror://gentoo/${P}.tbz2 http://dev.gentoo.org/~phosphan/${P}.tbz2"
LICENSE="GPL-2 as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND="x11-libs/libXext"
RDEPEND="${DEPEND}
	media-sound/toolame
	media-video/mjpegtools
	media-video/vcdimager
	dev-lang/tk" # gets it wrong otherwise because of inherited eclasses

src_compile() {
	get_version
	emake CC="$(tc-getCC)" V4LDIR="${KERNEL_DIR}/drivers/char" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin nuvrepairsync.tcl
	dodoc README LICENSE* Sound-Howto.txt
}
