# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p13.ebuild,v 1.2 2002/07/21 03:07:45 seemant Exp $

P_V=${P/_p/.p}
S=${WORKDIR}/${P_V}
DESCRIPTION="GTK ALSA audio mixer gamix by Fumihiko Murata <fmurata@p1.tcnet.ne.jp>"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${P_V}.tar.gz"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
LICENSE="GPL-2"

DEPEND=" >=media-sound/alsa-driver-0.9_rc1 
		>=media-libs/alsa-lib-0.9_rc1
		x11-libs/gtk+ 
		dev-libs/glib"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {

#	make \
#		prefix=${D}/usr \
#		mandir=${D}/usr/share/man \
#		infodir=${D}/usr/share/info \
		einstall || die
		dodoc README README.euc TODO NEWS INSTALL AUTHORS ABOUT-NLS COPYING
}

