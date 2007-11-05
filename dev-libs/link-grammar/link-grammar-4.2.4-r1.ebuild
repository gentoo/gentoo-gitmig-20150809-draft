# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/link-grammar/link-grammar-4.2.4-r1.ebuild,v 1.5 2007/11/05 20:39:44 jer Exp $

inherit eutils

DESCRIPTION="The Link Grammar Parser is a syntactic parser of English, based on
link grammar, an original theory of English syntax."
HOMEPAGE="http://bobo.link.cs.cmu.edu/link/"
SRC_URI="http://www.abisource.com/downloads/link-grammar/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

#broken make files :-/
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix bug #196803
	epatch "${FILESDIR}"/${P}-tokenize.patch
}

src_compile() {
	econf || die "configure failed"
	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README
}
