# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ezusb2131/ezusb2131-1.0.ebuild,v 1.1 2003/05/22 11:15:09 jje Exp $

MY_P=${PN/e/E}-${PV}
DESCRIPTION="This is a firmware uploader for EZ-USB devices"
HOMEPAGE="http://ezusb2131.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezusb2131/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=""

RDEPEND="sys-apps/hotplug"

S=${WORKDIR}/Ezusb2131
src_compile() {
	einfo "${S}"
	make all || die
}

src_install() {
	cp Makefile Makefile~
	sed -e 's/INSTALLDIR = \/lib\/modules/INSTALLDIR = ${D}\/lib\/modules/' \
	    -e 's/depmod -a/#depmod -a/' Makefile~ > Makefile

	make install || die
	dodoc ${S}/README ${S}/COPYING ${S}/AUTHORS
}

pkg_postinst() {
	einfo "Updating modules dependancies"
	depmod -a
}

