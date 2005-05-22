# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails/rails-0.10.0-r1.ebuild,v 1.4 2005/05/22 15:25:39 swegener Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="ruby on rails is a web-application and persistance framework"
HOMEPAGE="http://www.rubyonrails.org"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3205/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

IUSE="mysql sqlite postgres"
DEPEND="=dev-lang/ruby-1.8*
	>=dev-ruby/rake-0.4.15-r1
	>=dev-ruby/activesupport-1.0.0
	>=dev-ruby/activerecord-1.7.0
	>=dev-ruby/actionmailer-0.7.0
	>=dev-ruby/actionwebservice-0.5.0
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	mysql? ( >=dev-ruby/mysql-ruby-2.5 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )"


pkg_postinst() {
	einfo "If you have an existing Rails 0.9.5 application you'd like to"
	einfo "upgrade to 0.10.0 please follow these instructions:"
	einfo "http://manuals.rubyonrails.com/read/book/15"
}
