# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10g.ebuild,v 1.6 2004/03/12 15:17:00 aliz Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Utility for opening arj archives."
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/arj/${P}.tar.gz"

KEYWORDS="x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

RESTRICT=nostrip

src_compile() {
	epatch ${FILESDIR}/arj-3.10.18-2.6.headers.patch || die "Failed to apply 2.6 headers patch!"
	cd gnu
	autoconf
	econf || die
	cd ../
	make prepare || die "make prepare failed"
	make package || die "make package failed"
}

src_install() {
	cd ${S}/linux-gnu/en/rs/u
	dobin bin/*
	dodoc doc/arj/* ${S}/ChangeLog
}
