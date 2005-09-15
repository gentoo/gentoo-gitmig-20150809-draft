# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/og/og-0.23.0.ebuild,v 1.1 2005/09/15 22:40:02 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Og (ObjectGraph) is a powerfull object-relational mapping library."
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	=dev-ruby/glue-0.23.0"
