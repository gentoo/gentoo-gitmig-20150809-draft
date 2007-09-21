# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/png/png-1.1.0.ebuild,v 1.1 2007/09/21 23:03:01 agorf Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="An almost pure-Ruby Portable Network Graphics (PNG) library."
HOMEPAGE="http://rubyforge.org/projects/seattlerb/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-ruby/ruby-inline-3.5.0
		>=dev-ruby/hoe-1.2.0
		>=dev-lang/ruby-1.8.4"
RDEPEND="${DEPEND}"
