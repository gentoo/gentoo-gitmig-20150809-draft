# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/nemesis/nemesis-1.32.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A commandline-based, portable human IP stack for UNIX/Linux"
SRC_URI="http://jeff.wwti.com/nemesis/${P}.tar.gz"
HOMEPAGE="http://jeff.wwti.com/nemesis/"
KEYWORDS="x86 sparc sparc64"
LICENSE="as-is"
SLOT="0"

RDEPEND="virtual/glibc >=net-libs/libpcap-0.6.2-r1"
DEPEND="${RDEPEND} >=net-libs/libnet-1.0.2a"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"
}

src_install () {
	dodir /usr/sbin /usr/share/man/man1
	make DESTDIR=${D} install || die
}
