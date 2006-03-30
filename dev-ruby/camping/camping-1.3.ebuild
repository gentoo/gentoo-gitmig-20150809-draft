# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-1.3.ebuild,v 1.2 2006/03/30 03:23:17 agriffis Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A tiny web framework - a Rails microcosm"
HOMEPAGE="http://rubyforge.org/projects/camping/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/markaby-0.3
	>=dev-ruby/metaid-1.0
	>=dev-ruby/activerecord-1.13.2"
