# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/png/png-1.2.0.ebuild,v 1.3 2010/05/22 15:34:50 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="An almost pure-Ruby Portable Network Graphics (PNG) library."
HOMEPAGE="http://rubyforge.org/projects/seattlerb/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# ruby-inline dependency is not listed in gemspec, #276179
DEPEND=">=dev-ruby/rubygems-1.3.0"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-inline-3.5.0"
