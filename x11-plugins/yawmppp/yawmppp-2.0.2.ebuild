# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/yawmppp/yawmppp-2.0.2.ebuild,v 1.7 2010/07/22 14:35:43 ssuominen Exp $

inherit eutils

DESCRIPTION="Yet Another PPP Window Maker dock applet"
SRC_URI="ftp://ftp.seul.org/pub/yawmppp/${P}.tar.gz"
HOMEPAGE="http://yawmppp.seul.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=">=net-dialup/ppp-2.3.11
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd "${S}"/src/dockapp

	#Fix bug #95959
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodoc README CHANGELOG FAQ

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
