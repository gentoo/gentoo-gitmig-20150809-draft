# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.6-r1.ebuild,v 1.3 2003/04/02 14:00:00 joker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~arm"

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	epatch ${FILESDIR}/xmlstatus.patch || die "patch failed"
}

src_compile() {
	econf 
	# parallel make doesnt work
	make || die
}

src_install() {
	einstall \
		mandir=${D}/usr/share/man/man1
	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
