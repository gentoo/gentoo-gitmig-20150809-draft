# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/glue/glue-0.22.0.ebuild,v 1.1 2005/08/16 16:19:54 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="Glue utilities for Nitro."
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://rubyforge.org/frs/download.php/5465/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/facets-0.7.2"
