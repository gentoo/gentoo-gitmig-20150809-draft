# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbkup/cdbkup-1.0.ebuild,v 1.5 2003/02/13 05:59:52 vapier Exp $

DESCRIPTION="cdbkup performs full or incremental backups of local or remote filesystems onto CD-R(W)s."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://cdbkup.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc 
        >=app-cdr/cdrtools-1.11.28
        >=sys-apps/eject-2.0.10"

src_unpack() {
	unpack ${A} ; cd ${S}

	cp Makefile.in Makefile.in.orig
	sed "s:doc/cdbkup:doc/${P}:" Makefile.in.orig > Makefile.in

	#apply the patch
	patch < ${S}/linuxtar_13.patch ${S}/src/cdbkup.in
}

src_compile() {
	econf --with-snardir=/etc/cdbkup --with-dumpgrp=users
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COMPLIANCE ChangeLog README TODO 
}
