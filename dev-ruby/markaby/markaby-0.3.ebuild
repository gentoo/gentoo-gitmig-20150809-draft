# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/markaby/markaby-0.3.ebuild,v 1.2 2006/03/30 03:33:02 agriffis Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A templating language for Ruby to write HTML templates in pre Ruby"
HOMEPAGE="http://rubyforge.org/projects/markaby/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/builder-1.2.4"
