# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/tiobench/tiobench-0.3.3-r1.ebuild,v 1.4 2004/07/18 17:29:31 aliz Exp $

DESCRIPTION="Portable, robust, fully-threaded I/O benchmark program"
HOMEPAGE="http://tiobench.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="virtual/libc
	dev-lang/perl"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:/usr/local/bin:/usr/sbin:' tiobench.pl \
		|| die "sed tiobench.pl failed"
	sed -i \
		-e '/DLARGEFILES/ s/^#//' \
		-e "/^CFLAGS/ s:=.*:= ${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin tiotest tiobench.pl tiosum.pl || die "dosbin failed"
	dodoc BUGS ChangeLog README TODO
}
