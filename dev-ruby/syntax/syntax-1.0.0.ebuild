# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/syntax/syntax-1.0.0.ebuild,v 1.1 2005/10/22 13:30:22 twp Exp $

inherit ruby gems

DESCRIPTION="Syntax highlighting for sourcecode and html"
HOMEPAGE="http://syntax.rubyforge.org"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="any"
DEPEND="virtual/ruby"
