# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p13.ebuild,v 1.7 2003/09/07 00:06:05 msterret Exp $

P_V=${P/_p/.p}
S=${WORKDIR}/${P_V}
DESCRIPTION="GTK ALSA audio mixer"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${P_V}.tar.gz"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND=">=media-sound/alsa-driver-0.9_rc1
	>=media-libs/alsa-lib-0.9_rc1
	x11-libs/gtk+
	dev-libs/glib"

src_compile() {
	econf `use_enable nls` || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc README README.euc TODO NEWS INSTALL AUTHORS ABOUT-NLS COPYING
}
