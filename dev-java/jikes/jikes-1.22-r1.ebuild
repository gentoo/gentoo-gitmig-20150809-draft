# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.22-r1.ebuild,v 1.3 2005/03/25 18:52:19 axxo Exp $

inherit flag-o-matic eutils

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://jikes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
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
