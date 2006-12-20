# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shipping/shipping-1.3.0.ebuild,v 1.1 2006/12/20 00:35:11 pclouds Exp $

inherit ruby gems

DESCRIPTION="An easy to use shipping API for Ruby"
HOMEPAGE="http://shipping.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="any"
DEPEND=">=dev-ruby/builder-1.2.0"
