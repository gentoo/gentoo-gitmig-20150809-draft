# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nemesis/nemesis-1.32.ebuild,v 1.6 2002/12/09 04:33:16 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A commandline-based, portable human IP stack for UNIX/Linux"
SRC_URI="http://jeff.wwti.com/nemesis/${P}.tar.gz"
HOMEPAGE="http://jeff.wwti.com/nemesis/"
KEYWORDS="x86 sparc "
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
