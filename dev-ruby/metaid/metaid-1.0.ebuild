# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metaid/metaid-1.0.ebuild,v 1.7 2010/05/22 15:23:44 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An aid to Ruby metaprogramming"
HOMEPAGE="http://rubyforge.org/projects/metaid/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2"
