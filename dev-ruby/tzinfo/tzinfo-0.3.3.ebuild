# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tzinfo/tzinfo-0.3.3.ebuild,v 1.4 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

DESCRIPTION="Library to provide daylight-savings aware transformations between timezones"
HOMEPAGE="http://tzinfo.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~ppc ~x86"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="virtual/ruby"
