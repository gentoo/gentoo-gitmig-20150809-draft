# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyforge/rubyforge-0.3.1.ebuild,v 1.2 2007/01/05 00:24:32 kloeri Exp $

inherit ruby gems

DESCRIPTION="Simplistic script which automates a limited set of rubyforge operations"
HOMEPAGE="http://codeforpeople.com/lib/ruby/rubyforge/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.4"
