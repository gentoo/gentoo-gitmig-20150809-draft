# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/og/og-0.40.0.ebuild,v 1.1 2006/12/07 16:04:37 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Og (ObjectGraph) is a powerfull object-relational mapping library."
HOMEPAGE="http://www.nitroproject.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE="mysql postgres sqlite kirbybase"

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/glue-${PV}
	mysql? ( >=dev-ruby/mysql-ruby-2.7.2 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	kirbybase? ( >=dev-ruby/kirbybase-2.3 )"


