# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p13-r1.ebuild,v 1.2 2004/02/17 19:06:35 ciaranm Exp $

IUSE="nls"

P_V=${P/_p/.p}
S=${WORKDIR}/${P_V}
DESCRIPTION="GTK ALSA audio mixer"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${P_V}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="virtual/alsa
	=x11-libs/gtk+-1.2*"

src_compile() {
	econf `use_enable nls` || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc README README.euc TODO NEWS INSTALL AUTHORS ABOUT-NLS COPYING
}
