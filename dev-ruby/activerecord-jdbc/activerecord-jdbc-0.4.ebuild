# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord-jdbc/activerecord-jdbc-0.4.ebuild,v 1.1 2007/06/22 04:34:41 nichoj Exp $

inherit ruby gems

MY_PN="ActiveRecord-JDBC"
MY_P="${MY_PN}-${PV}"
USE_RUBY="ruby18"
DESCRIPTION="A database adapter for Rails' ActiveRecord component that can be used with JRuby"
HOMEPAGE="http://rubyforge.org/projects/activerecord/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86" 
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5"
