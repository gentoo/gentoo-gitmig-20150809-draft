# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.3.4.ebuild,v 1.12 2004/10/05 13:58:11 pvdabeel Exp $

inherit flag-o-matic

IUSE=""

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.gnucash.org"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"

SLOT="1.3"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc amd64"

DEPEND=">=dev-util/guile-1.4
	>=dev-libs/slib-2.4.2"

src_compile() {
	filter-flags "-O?"
	econf \
		--libexecdir=/usr/lib/misc || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
