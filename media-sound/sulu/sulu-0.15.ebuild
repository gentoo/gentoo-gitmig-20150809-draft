# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sulu/sulu-0.15.ebuild,v 1.1 2003/03/02 05:13:43 alron Exp $

DESCRIPTION="Samsung Uproar Linux Utility (sulu)"
HOMEPAGE="http://www.cs.toronto.edu/~kal/sulu/index.html"
SRC_URI="http://www.cs.toronto.edu/~kal/sulu/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libusb-0.1.7
		>=media-sound/lame-3.93.1
		>=media-sound/mpg123-0.59
		=x11-libs/gtk+-1.2*
		>=sys-apps/hotplug-20020826"

S=${WORKDIR}/${P}

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
		insinto /etc/hotplug
		doins ${FILESDIR}/usb.usermap
}
