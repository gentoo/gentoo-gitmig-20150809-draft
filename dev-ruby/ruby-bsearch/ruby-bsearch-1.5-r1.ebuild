# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bsearch/ruby-bsearch-1.5-r1.ebuild,v 1.3 2004/02/17 00:46:35 agriffis Exp $

inherit ruby

DESCRIPTION="A binary search library for Ruby"
HOMEPAGE="http://namazu.org/~satoru/ruby-bsearch/"
SRC_URI="http://namazu.org/~satoru/ruby-bsearch/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha ~arm ~hppa ~mips ~ppc sparc x86 ia64"
IUSE=""
DEPEND="dev-lang/ruby"

DOCS="ChangeLog *.rd bsearch.png"
