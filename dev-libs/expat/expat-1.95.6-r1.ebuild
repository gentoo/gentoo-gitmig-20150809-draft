# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.6-r1.ebuild,v 1.14 2004/03/21 11:23:42 kumba Exp $

inherit eutils gnuconfig

DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 x86 ppc sparc alpha hppa ia64 mips"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	epatch ${FILESDIR}/xmlstatus.patch
}

src_compile() {

	# Detect mips systems properly
	use mips && gnuconfig_update

	econf || die
	# parallel make doesnt work
	make || die
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1
	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
