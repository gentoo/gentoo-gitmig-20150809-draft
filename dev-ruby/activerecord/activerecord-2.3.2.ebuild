# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord/activerecord-2.3.2.ebuild,v 1.3 2009/05/23 14:52:47 ranger Exp $

inherit ruby gems
USE_RUBY="ruby18 ruby19"

DESCRIPTION="Implements the ActiveRecord pattern (Fowler, PoEAA) for ORM"
HOMEPAGE="http://rubyforge.org/projects/activerecord/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="mysql postgres sqlite sqlite3"
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.6
	~dev-ruby/activesupport-2.3.2
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	sqlite3? ( dev-ruby/sqlite3-ruby )
	mysql? ( >=dev-ruby/mysql-ruby-2.7 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )"
