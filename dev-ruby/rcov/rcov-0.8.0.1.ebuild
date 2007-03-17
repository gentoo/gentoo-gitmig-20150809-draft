# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcov/rcov-0.8.0.1.ebuild,v 1.2 2007/03/17 16:24:34 robbat2 Exp $

inherit ruby gems

DESCRIPTION="A ruby code coverage analysis tool"
HOMEPAGE="http://eigenclass.org/hiki.rb?rcov"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.3"
