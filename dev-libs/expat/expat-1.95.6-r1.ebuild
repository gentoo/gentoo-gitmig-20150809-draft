# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.6-r1.ebuild,v 1.18 2004/07/14 14:19:00 agriffis Exp $

inherit eutils gnuconfig

DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 x86 ppc sparc alpha hppa ia64 mips"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	epatch ${FILESDIR}/xmlstatus.patch
	cd ${S}
	epatch ${FILESDIR}/expat-1.95.6-uclibc.patch
}

src_compile() {

	# Detect mips systems properly
	gnuconfig_update

	econf || die
	# parallel make doesnt work
	make || die
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1
	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
