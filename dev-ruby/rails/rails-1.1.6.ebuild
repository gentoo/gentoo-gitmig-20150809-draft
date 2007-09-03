# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails/rails-1.1.6.ebuild,v 1.4 2007/09/03 21:14:44 nichoj Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="ruby on rails is a web-application and persistance framework"
HOMEPAGE="http://www.rubyonrails.org"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="1.1"
KEYWORDS="amd64 ia64 ppc sparc x86 ~x86-fbsd"

IUSE="mysql sqlite sqlite3 postgres fastcgi"
DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rake-0.7.1
	=dev-ruby/activerecord-1.14.4
	=dev-ruby/actionmailer-1.2.5
	=dev-ruby/actionwebservice-1.1.6
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.6 )
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	sqlite3? ( dev-ruby/sqlite3-ruby )
	mysql? ( >=dev-ruby/mysql-ruby-2.7 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )
	!~dev-ruby/rails-1.2.0
	!~dev-ruby/rails-1.2.1
	!=dev-ruby/rails-1.2.3"
