# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /home/cvsroot/gentoo-x86/app-cdr/cdbkup-1.0.ebuild,v 1.0 2002/07/27 01:09:30 raker Exp 

S=${WORKDIR}/${P}
DESCRIPTION="cdbkup performs full or incremental backups of local or remote filesystems onto CD-R(W)s."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://cdbkup.sourceforge.net/"

DEPEND="virtual/glibc 
        >=app-cdr/cdrtools-1.11.28
        >=sys-apps/eject-2.0.10"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	cd ${S}

	cp Makefile.in Makefile.in.orig
	sed "s:doc/cdbkup:doc/${P}:" Makefile.in.orig > Makefile.in

	#apply the patch
	patch < ${S}/linuxtar_13.patch ${S}/src/cdbkup.in
}

src_compile() {
	local myconf
	myconf="--with-snardir=/etc/cdbkup --with-dumpgrp=users"

	econf ${myconf} || die "configure failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COMPLIANCE  ChangeLog README  TODO 
}
