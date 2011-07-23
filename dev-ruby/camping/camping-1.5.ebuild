# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-1.5.ebuild,v 1.4 2011/07/23 10:51:45 xarthisius Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A web microframework inspired by Ruby on Rails."
HOMEPAGE="http://code.whytheluckystiff.net/camping/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/markaby-0.5
	>=dev-ruby/metaid-1.0
	>=dev-ruby/activerecord-1.14.2"
