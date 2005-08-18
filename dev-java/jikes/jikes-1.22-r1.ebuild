# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.22-r1.ebuild,v 1.10 2005/08/18 18:31:37 hansmi Exp $

inherit flag-o-matic eutils

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://jikes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc sparc x86"
IUSE=""
DEPEND=""

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

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING AUTHORS README TODO NEWS
}
