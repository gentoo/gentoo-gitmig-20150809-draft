# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shipping/shipping-1.6.0.ebuild,v 1.1 2009/11/28 10:28:35 a3li Exp $

inherit ruby gems

DESCRIPTION="An easy to use shipping API for Ruby"
HOMEPAGE="http://shipping.rubyforge.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-ruby/builder-1.2.0"
