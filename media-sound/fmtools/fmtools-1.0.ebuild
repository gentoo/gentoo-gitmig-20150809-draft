# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmtools/fmtools-1.0.ebuild,v 1.1 2005/03/29 02:11:39 luckyduck Exp $

IUSE=""

DESCRIPTION="A collection of programs for controlling v4l radio card drivers."
HOMEPAGE="http://www.stanford.edu/~blp/fmtools/"
SRC_URI="http://www.stanford.edu/~blp/fmtools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 -ppc -sparc -alpha"

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
