# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sulu/sulu-0.15.ebuild,v 1.6 2004/04/01 08:26:05 eradicator Exp $

DESCRIPTION="Samsung Uproar Linux Utility (sulu)"
HOMEPAGE="http://www.cs.toronto.edu/~kal/sulu/index.html"
SRC_URI="http://www.cs.toronto.edu/~kal/sulu/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-libs/libusb-0.1.7
		>=media-sound/lame-3.93.1
		virtual/mpg123
		=x11-libs/gtk+-1.2*
		>=sys-apps/hotplug-20020826"

src_compile() {
	make || die
}

src_install() {
		dodoc COPYING README changelog todo
		docinto notes
		cp -a notes/* ${D}/usr/share/doc/${PF}/notes
		prepalldocs
		exeinto /usr/bin
		doexe sulu
		exeinto /etc/hotplug/usb
		doexe ${FILESDIR}/uproar
		insinto /etc/hotplug/usb
		doins ${FILESDIR}/uproar.usermap
}
pkg_postinst() {
		einfo "Remember to enable hotplug in your kernel and in"
		einfo "your default runlevel to use sulu as a user instead"
		einfo "of as root."
}
