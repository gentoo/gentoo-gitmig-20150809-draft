# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.1.ebuild,v 1.1 2001/11/05 19:01:11 verwilst Exp $

DESCRIPTION="TightVNC 1.2.1"
SRC_URI="http://prdownloads.sourceforge.net/vnc-tight/tightvnc-1.2.1_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"

DEPEND="virtual/glibc
		>=x11-base/xfree-4.0.3
		>=sys-devel/perl-5.6.1"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack tightvnc-1.2.1_unixsrc.tar.bz2
	mv vnc_unixsrc tightvnc-1.2.1
	cd ${P}

}

src_compile() {

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
