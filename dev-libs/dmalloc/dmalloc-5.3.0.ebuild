# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.3.0.ebuild,v 1.3 2004/06/24 23:05:51 agriffis Exp $

inherit debug eutils

DESCRIPTION="A Debug Malloc Library"
HOMEPAGE="http://dmalloc.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
}

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake all threads shlib tests || die "emake failed"
}

src_install() {
	# install extra docs
	dodoc ChangeLog INSTALL TODO NEWS NOTES README
	dohtml Release.html dmalloc.html

	make prefix=${D}/usr install installth installsl
	doinfo dmalloc.info
}
