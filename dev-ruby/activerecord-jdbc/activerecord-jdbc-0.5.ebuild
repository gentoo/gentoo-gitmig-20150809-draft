# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord-jdbc/activerecord-jdbc-0.5.ebuild,v 1.2 2010/01/24 13:27:26 graaff Exp $

inherit ruby gems

MY_PN="ActiveRecord-JDBC"
MY_P="${MY_PN}-${PV}"
USE_RUBY="ruby18"
DESCRIPTION="A database adapter for Rails' ActiveRecord component that can be used with JRuby"
HOMEPAGE="http://jruby-extras.rubyforge.org/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
