# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbkup/cdbkup-1.0.ebuild,v 1.11 2004/03/12 12:02:37 mr_bones_ Exp $

DESCRIPTION="cdbkup performs full or incremental backups of local or remote filesystems onto CD-R(W)s."
SRC_URI="mirror://sourceforge/cdbkup/${P}.tar.gz"
HOMEPAGE="http://cdbkup.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc
	>=app-cdr/cdrtools-1.11.28
	>=sys-apps/eject-2.0.10
	!app-misc/cdcat"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i "s:doc/cdbkup:doc/${P}:" Makefile.in

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
