# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/adhearsion/adhearsion-0.7.5.ebuild,v 1.1 2007/03/13 12:04:51 pingu Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="'Adhesion you can hear' for integrating VoIP"
HOMEPAGE="http://adhearsion.com"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rake-0.7.1
	>=dev-ruby/activerecord-1.14.4"
