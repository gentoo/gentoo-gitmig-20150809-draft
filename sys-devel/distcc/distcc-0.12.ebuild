# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-0.12.ebuild,v 1.5 2002/11/12 07:59:49 seemant Exp $

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/${PN}/${P}.tar.gz"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc
	dev-libs/popt"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	dobin src/distcc src/distccd
	exeinto /etc/init.d
	doexe ${FILESDIR}/distccd
	doman man/*.1
	dodoc README COPYING* AUTHORS *NEWS doc/*.txt linuxdoc/distcc*
	dohtml linuxdoc/html/*
}
