# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbkup/cdbkup-1.0.ebuild,v 1.12 2004/03/30 00:08:30 mr_bones_ Exp $

inherit eutils

DESCRIPTION="cdbkup performs full or incremental backups of local or remote filesystems onto CD-R(W)s."
HOMEPAGE="http://cdbkup.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbkup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/glibc
	>=app-cdr/cdrtools-1.11.28
	>=sys-apps/eject-2.0.10
	!app-misc/cdcat"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i \
		-e "s:doc/cdbkup:doc/${P}:" Makefile.in \
			|| die "sed Makefile.in failed"

	#apply the patch
	epatch ${S}/linuxtar_13.patch
}

src_compile() {
	econf --with-snardir=/etc/cdbkup --with-dumpgrp=users
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc COMPLIANCE ChangeLog README TODO
}
