# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-0.11.ebuild,v 1.1 2002/09/25 13:00:32 mjc Exp $

HOMEPAGE="http://distcc.samba.org"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.gz"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	dev-libs/popt"
DEPEND="${RDEPEND}"

src_compile() {
	./configure --prefix=/usr \
		    --mandir=/usr/share/man || die "configure problem"
	emake
}

src_install () {
	dobin src/distcc src/distccd
	doman man/*.1
	dodoc README COPYING* AUTHORS *NEWS doc/*.txt linuxdoc/distcc*
	dohtml linuxdoc/html/*
}
