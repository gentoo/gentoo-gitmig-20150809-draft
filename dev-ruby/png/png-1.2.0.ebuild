# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/png/png-1.2.0.ebuild,v 1.1 2009/06/27 11:05:42 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="An almost pure-Ruby Portable Network Graphics (PNG) library."
HOMEPAGE="http://rubyforge.org/projects/seattlerb/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/rubygems-1.3.0"
RDEPEND="${DEPEND}"
