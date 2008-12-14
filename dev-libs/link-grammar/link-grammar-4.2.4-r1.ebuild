# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/link-grammar/link-grammar-4.2.4-r1.ebuild,v 1.9 2008/12/14 22:40:04 eva Exp $

inherit eutils

DESCRIPTION="The Link Grammar Parser is a syntactic parser of English, based on
link grammar, an original theory of English syntax."
HOMEPAGE="http://bobo.link.cs.cmu.edu/link/"
SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix bug #196803
	epatch "${FILESDIR}"/${P}-tokenize.patch
}

src_compile() {
	econf

	# broken make files :-/
	emake -j1 || die "emake failed"
}

src_install() {
	# broken make files :-/
	emake -j1 DESTDIR="${D}" install || die "install failed"
	dodoc README
}
