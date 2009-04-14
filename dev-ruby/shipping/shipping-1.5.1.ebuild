# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shipping/shipping-1.5.1.ebuild,v 1.2 2009/04/14 17:49:29 graaff Exp $

inherit ruby gems

DESCRIPTION="An easy to use shipping API for Ruby"
HOMEPAGE="http://shipping.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-ruby/builder-1.2.0"
