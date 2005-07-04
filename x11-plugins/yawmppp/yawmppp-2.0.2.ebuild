# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/yawmppp/yawmppp-2.0.2.ebuild,v 1.1 2005/07/04 10:06:07 s4t4n Exp $

DESCRIPTION="Yet Another PPP Window Maker dock applet"
SRC_URI="ftp://ftp.seul.org/pub/yawmppp/${P}.tar.gz"
HOMEPAGE="http://yawmppp.seul.org/"
DEPEND=">=net-dialup/ppp-2.3.11 =x11-libs/gtk+-1.2*"
#RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodoc README COPYING CHANGELOG INSTALL FAQ

	cd src

	insinto /usr/share/icons/
	doins stepphone.xpm gtksetup/pppdoc.xpm

	doman yawmppp.1x

	dobin dockapp/yawmppp
	exeinto /etc/ppp
	doexe dockapp/yagetmodemspeed

	dobin thinppp/yawmppp.thin
	dobin gtklog/yawmppp.log
	dobin gtksetup/yawmppp.pref
}
