# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bsfilter/bsfilter-1.0.6.ebuild,v 1.1 2005/01/12 18:42:59 nakano Exp $

DESCRIPTION="bayesian spam filter which distinguishes spam and non-spam mail"
HOMEPAGE="http://bsfilter.org/index-e.html"
SRC_URI="mirror://sourceforge.jp/bsfilter/12638/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
