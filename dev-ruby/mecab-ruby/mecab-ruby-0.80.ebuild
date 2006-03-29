# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mecab-ruby/mecab-ruby-0.80.ebuild,v 1.4 2006/03/29 15:23:27 agriffis Exp $

inherit ruby eutils

DESCRIPTION="MeCab library module for Ruby"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"
SRC_URI="http://chasen.org/~taku/software/mecab/bindings/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 ~x86"
IUSE=""

DEPEND="virtual/ruby
	>=app-text/mecab-0.80"
