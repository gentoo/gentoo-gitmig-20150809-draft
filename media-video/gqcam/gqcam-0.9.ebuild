# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gqcam/gqcam-0.9.ebuild,v 1.16 2006/10/04 21:56:58 vapier Exp $

inherit eutils

DESCRIPTION="A V4L-compatible frame grabber - works with many webcams"
HOMEPAGE="http://cse.unl.edu/~cluening/gqcam/"
SRC_URI="http://cse.unl.edu/~cluening/gqcam/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b-r2
	>=media-libs/libpng-1.2.1-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-strlen.patch
}

src_install() {
	dobin gqcam || die
	dodoc CHANGES README README.threads
}
