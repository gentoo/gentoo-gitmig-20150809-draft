# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/link-grammar/link-grammar-4.2.4.ebuild,v 1.1 2007/08/15 10:33:19 eva Exp $

DESCRIPTION=" The Link Grammar Parser is a syntactic parser of English, based on
link grammar, an original theory of English syntax."
HOMEPAGE="http://bobo.link.cs.cmu.edu/link/"
SRC_URI="http://www.abisource.com/downloads/link-grammar/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

#broken make files :-/
MAKEOPTS=-j1

src_configure() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc LICENSE README
}
