# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmtools/fmtools-0.99.1.ebuild,v 1.6 2004/07/01 07:51:39 eradicator Exp $

IUSE=""

DESCRIPTION="A collection of programs for controlling v4l radio card drivers."
HOMEPAGE="http://www.exploits.org/v4l/fmtools/index.html"
SRC_URI="http://www.exploits.org/v4l/fmtools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha amd64"

DEPEND="virtual/libc"

src_compile() {
	make || die
}

src_install() {
	dobin fm
	dobin fmscan
	doman fm.1
	doman fmscan.1
	dodoc README CHANGES COPYING
}
