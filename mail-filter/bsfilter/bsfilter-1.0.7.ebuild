# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bsfilter/bsfilter-1.0.7.ebuild,v 1.6 2010/08/07 13:32:24 graaff Exp $

DESCRIPTION="bayesian spam filter which distinguishes spam and non-spam mail"
HOMEPAGE="http://bsfilter.org/index-e.html"
SRC_URI="mirror://sourceforge.jp/bsfilter/14691/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="mecab chasen"

DEPEND="=dev-lang/ruby-1.8*"

RDEPEND="${DEPEND}
	mecab? ( dev-ruby/mecab-ruby )
	chasen? ( dev-ruby/ruby-chasen )"

src_compile() {
	einfo "nothing to do in src_compile()"
}

src_install() {
	dobin bsfilter/bsfilter || die
	dohtml -r htdocs/*
}
