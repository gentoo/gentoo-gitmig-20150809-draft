# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10.18.ebuild,v 1.4 2004/03/12 15:17:00 aliz Exp $

inherit gnuconfig eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Utility for opening arj archives."
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/arj/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

RESTRICT=nostrip

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/${P}-2.6.headers.patch
}

src_compile() {
	gnuconfig_update

	cd ${S}/gnu
	autoconf
	econf || die

	cd ${S}
	make prepare || die "make prepare failed"
	make package || die "make package failed"
}

src_install() {
	cd ${S}/linux-gnu/en/rs/u
	dobin bin/*
	dodoc doc/arj/* ${S}/ChangeLog
}
