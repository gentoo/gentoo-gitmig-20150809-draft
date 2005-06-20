# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbkup/cdbkup-1.0-r1.ebuild,v 1.6 2005/06/20 00:47:12 flameeyes Exp $

inherit eutils

DESCRIPTION="performs full/incremental backups of local/remote filesystems onto CD-R(W)s"
HOMEPAGE="http://cdbkup.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbkup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=app-cdr/cdrtools-1.11.28"
RDEPEND="${DEPEND}
	virtual/eject
	!app-misc/cdcat"

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
