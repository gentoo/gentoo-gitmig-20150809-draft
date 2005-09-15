# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/glue/glue-0.23.0.ebuild,v 1.1 2005/09/15 22:35:40 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="Glue utilities for Nitro."
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/nano-methods-0.8.2
	>=dev-ruby/mega-modules-0.3.1"
