# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bsearch/ruby-bsearch-1.5-r1.ebuild,v 1.13 2004/09/16 01:56:56 pvdabeel Exp $

inherit ruby

DESCRIPTION="A binary search library for Ruby"
HOMEPAGE="http://namazu.org/~satoru/ruby-bsearch/"
SRC_URI="http://namazu.org/~satoru/ruby-bsearch/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa ~mips ppc sparc x86 ia64 macos amd64 ppc64 ppc-macos"
IUSE=""
USE_RUBY="any"
DEPEND="dev-lang/ruby"

DOCS="ChangeLog *.rd bsearch.png"
