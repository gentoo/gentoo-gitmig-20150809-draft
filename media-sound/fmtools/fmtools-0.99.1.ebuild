# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmtools/fmtools-0.99.1.ebuild,v 1.3 2003/11/16 18:43:01 brad_mssw Exp $

IUSE=""

DESCRIPTION="A collection of programs for controlling v4l radio card drivers."
HOMEPAGE="http://www.exploits.org/v4l/fmtools/index.html"
SRC_URI="http://www.exploits.org/v4l/fmtools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha amd64"

DEPEND="virtual/glibc"

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
