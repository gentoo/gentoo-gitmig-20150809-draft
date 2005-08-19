# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-activeldap/ruby-activeldap-0.5.7.ebuild,v 1.1 2005/08/19 15:03:38 tigger Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Ruby/ActiveLDAP provides an activerecord inspired object oriented interface to LDAP"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-activeldap/"
SRC_URI="http://gems.rubyforge.org/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="=dev-lang/ruby-1.8*
	>=dev-ruby/ruby-ldap-0.8.2
	dev-ruby/log4r"
