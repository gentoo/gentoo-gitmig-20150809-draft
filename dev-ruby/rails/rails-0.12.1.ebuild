# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails/rails-0.12.1.ebuild,v 1.3 2005/07/12 11:14:21 dholm Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="ruby on rails is a web-application and persistance framework"
HOMEPAGE="http://www.rubyonrails.org"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/4158/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="mysql sqlite postgres fastcgi"
DEPEND="=dev-lang/ruby-1.8*
	>=dev-ruby/rake-0.5.3
	>=dev-ruby/activerecord-1.10.1
	>=dev-ruby/actionmailer-0.9.1
	>=dev-ruby/actionwebservice-0.7.1
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.5-r1 )
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	mysql? ( >=dev-ruby/mysql-ruby-2.5 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )"
