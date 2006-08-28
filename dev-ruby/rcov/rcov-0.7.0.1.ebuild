# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcov/rcov-0.7.0.1.ebuild,v 1.1 2006/08/28 14:20:17 pclouds Exp $

inherit ruby gems

DESCRIPTION="A ruby code coverage analysis tool"
HOMEPAGE="http://eigenclass.org/hiki.rb?rcov"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.3"
