# Copyright 1999-2006 BreakMyGentoo.net
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tzinfo/tzinfo-0.3.2.ebuild,v 1.1 2006/11/23 00:44:22 flameeyes Exp $

inherit ruby gems

DESCRIPTION="Library to provide daylight-savings aware transformations between timezones"
HOMEPAGE="http://tzinfo.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="virtual/ruby"

