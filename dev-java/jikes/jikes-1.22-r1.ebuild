# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.22-r1.ebuild,v 1.1 2004/10/12 19:21:14 axxo Exp $

inherit flag-o-matic

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"
SRC_URI="ftp://www-126.ibm.com/pub/jikes/${PV}/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~alpha ~ia64 ~hppa"
IUSE=""
DEPEND="virtual/libc"
DEPEND=""
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/deprecated.patch
}

src_compile() {
	filter-flags "-fno-rtti"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
	|| die "configure problem"
	emake || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING AUTHORS README TODO NEWS
}
