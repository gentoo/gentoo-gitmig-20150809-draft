# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mecab-ruby/mecab-ruby-0.78.ebuild,v 1.2 2004/08/03 11:35:59 dholm Exp $

inherit ruby eutils

DESCRIPTION="MeCab library module for Ruby"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"
SRC_URI="http://chasen.org/~taku/software/mecab/bindings/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/ruby
	>=app-text/mecab-0.78"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}
