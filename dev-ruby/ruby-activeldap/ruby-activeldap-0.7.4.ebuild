# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-activeldap/ruby-activeldap-0.7.4.ebuild,v 1.1 2006/08/07 12:03:15 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Ruby/ActiveLDAP provides an activerecord inspired object oriented interface to LDAP"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-activeldap/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"

DEPEND="=dev-lang/ruby-1.8*
	>=dev-ruby/ruby-ldap-0.8.2
	dev-ruby/log4r"
