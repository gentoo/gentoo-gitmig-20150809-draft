# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbkup/cdbkup-1.0-r1.ebuild,v 1.4 2004/08/16 13:03:35 absinthe Exp $

inherit eutils

DESCRIPTION="performs full/incremental backups of local/remote filesystems onto CD-R(W)s"
HOMEPAGE="http://cdbkup.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbkup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="virtual/libc
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
}

src_compile() {
	econf --with-snardir=/etc/cdbkup --with-dumpgrp=users || die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc COMPLIANCE ChangeLog README TODO
}
