# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-1.7.0.ebuild,v 1.2 2007/08/15 10:27:05 trapni Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://rubyforge.org/projects/haml/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.4"
