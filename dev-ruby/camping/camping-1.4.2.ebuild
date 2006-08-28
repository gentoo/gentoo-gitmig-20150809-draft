# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-1.4.2.ebuild,v 1.1 2006/08/28 14:52:28 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A web microframework inspired by Ruby on Rails."
HOMEPAGE="http://code.whytheluckystiff.net/camping/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/markaby-0.4
	>=dev-ruby/metaid-1.0
	>=dev-ruby/activerecord-1.14.2"
