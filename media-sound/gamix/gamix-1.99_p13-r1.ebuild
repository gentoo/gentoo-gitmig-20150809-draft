# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p13-r1.ebuild,v 1.5 2004/03/01 04:54:53 eradicator Exp $

P_V=${P/_p/.p}
S=${WORKDIR}/${P_V}
DESCRIPTION="GTK ALSA audio mixer"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${P_V}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc ~alpha ~amd64 ~ia64"
IUSE="nls"

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
