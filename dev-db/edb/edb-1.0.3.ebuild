# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.3.ebuild,v 1.12 2004/03/19 01:56:42 vapier Exp $

DESCRIPTION="Enlightment Data Base"
HOMEPAGE="http://enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="virtual/glibc"

src_compile() {
	econf \
		--enable-compat185 \
		--enable-dump185 \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}
