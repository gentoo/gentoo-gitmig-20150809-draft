# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/og/og-0.40.0.ebuild,v 1.3 2007/05/13 16:32:14 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Og (ObjectGraph) is a powerfull object-relational mapping library."
HOMEPAGE="http://www.nitroproject.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE="mysql postgres sqlite3 kirbybase"

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/glue-${PV}
	mysql? ( >=dev-ruby/mysql-ruby-2.7.2 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )
	sqlite3? ( >=dev-ruby/sqlite3-ruby-1.2.1 )
	kirbybase? ( >=dev-ruby/kirbybase-2.3 )"


