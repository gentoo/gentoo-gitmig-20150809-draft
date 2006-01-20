# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-1.1.ebuild,v 1.1 2006/01/20 23:41:10 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A tiny web framework - a Rails microcosm"
HOMEPAGE="http://rubyforge.org/projects/camping/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/markaby-0.2
	>=dev-ruby/metaid-1.0
	>=dev-ruby/activerecord-1.13.2"
