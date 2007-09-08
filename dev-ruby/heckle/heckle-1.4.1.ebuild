# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heckle/heckle-1.4.1.ebuild,v 1.2 2007/09/08 12:30:17 nixnut Exp $

inherit ruby gems

DESCRIPTION="Unit Test Sadism"
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/ruby2ruby-1.1.0
		>=dev-ruby/zentest-3.5.2
		>=dev-ruby/hoe-1.2.1"
