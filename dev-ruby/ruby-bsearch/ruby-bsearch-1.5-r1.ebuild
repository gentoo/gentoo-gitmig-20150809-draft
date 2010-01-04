# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bsearch/ruby-bsearch-1.5-r1.ebuild,v 1.18 2010/01/04 11:52:19 fauli Exp $

inherit ruby

DESCRIPTION="A binary search library for Ruby"
HOMEPAGE="http://0xcc.net/ruby-bsearch/"
SRC_URI="http://0xcc.net/ruby-bsearch/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""
USE_RUBY="ruby18"
DEPEND="dev-lang/ruby"

DOCS="ChangeLog *.rd bsearch.png"
