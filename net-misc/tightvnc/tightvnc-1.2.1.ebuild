# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.1.ebuild,v 1.2 2001/12/14 22:56:01 verwilst Exp $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="TightVNC 1.2.1"
SRC_URI="http://prdownloads.sourceforge.net/vnc-tight/tightvnc-1.2.1_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"

DEPEND="virtual/glibc
		>=x11-base/xfree-4.0.3
		>=sys-devel/perl-5.6.1"

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
