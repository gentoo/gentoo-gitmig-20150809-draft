# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.3.4.ebuild,v 1.10 2004/06/24 23:12:00 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.gnucash.org"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="x86 ~ppc alpha sparc amd64"
IUSE=""

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
