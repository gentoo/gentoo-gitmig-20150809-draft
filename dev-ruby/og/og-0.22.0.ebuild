# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/og/og-0.22.0.ebuild,v 1.1 2005/08/16 16:23:09 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Og (ObjectGraph) is a powerfull object-relational mapping library."
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://rubyforge.org/frs/download.php/5468/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	=dev-ruby/glue-0.22.0"
