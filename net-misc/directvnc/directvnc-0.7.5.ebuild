# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/directvnc/directvnc-0.7.5.ebuild,v 1.3 2004/07/20 20:36:33 vapier Exp $

inherit eutils

DESCRIPTION="Very thin VNC client for unix framebuffer systems"
HOMEPAGE="http://adam-lilienthal.de/directvnc/"
SRC_URI="http://www.adam-lilienthal.de/directvnc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="dev-libs/DirectFB
	virtual/x11
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake DEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
