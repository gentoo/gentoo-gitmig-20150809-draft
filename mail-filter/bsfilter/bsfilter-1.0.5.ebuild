# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bsfilter/bsfilter-1.0.5.ebuild,v 1.2 2004/11/12 17:23:47 nakano Exp $

DESCRIPTION="bayesian spam filter which distinguishes spam and non-spam mail"
HOMEPAGE="http://bsfilter.org/index-e.html"
SRC_URI="mirror://sourceforge.jp/bsfilter/11988/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="mecab chasen"

DEPEND="virtual/ruby"

RDEPEND="${DEPEND}
	mecab? ( dev-ruby/mecab-ruby )
	chasen? ( dev-ruby/ruby-chasen )"

src_compile() {
	einfo "nothing to do in src_compile()"
}

src_install() {
	dobin bsfilter/bsfilter || die
	dohtml -r htdocs/*
	dodoc COPYING
}
