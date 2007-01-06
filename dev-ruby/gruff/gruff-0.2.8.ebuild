# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gruff/gruff-0.2.8.ebuild,v 1.1 2007/01/06 13:51:08 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A ruby library for creating pretty graphs and charts"
HOMEPAGE="http://rubyforge.org/projects/gruff/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~amd64"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	dev-ruby/rmagick"
