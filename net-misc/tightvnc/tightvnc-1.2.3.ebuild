# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.3.ebuild,v 1.4 2002/07/11 06:30:49 drobbins Exp $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/glibc
	>=x11-base/xfree-4.1.0
	>=sys-devel/perl-5.6.1
	>=sys-libs/zlib-1.1.4"

RDEPEND=$DEPEND

src_compile() {

	cd ${S}
	xmkmf || die
	make World || die
	cd Xvnc
	make World || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/bin
	./vncinstall ${D}/usr/bin || die

}
