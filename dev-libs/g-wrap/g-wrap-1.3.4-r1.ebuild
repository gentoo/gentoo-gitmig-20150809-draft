# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.3.4-r1.ebuild,v 1.7 2006/12/18 16:13:57 seemant Exp $

inherit eutils flag-o-matic

IUSE=""

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.gnucash.org"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND=">=dev-util/guile-1.4
	>=dev-libs/slib-2.4.2
	=dev-libs/glib-1*"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-direntry.patch
	epatch ${FILESDIR}/${P}-m4.patch
}

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
