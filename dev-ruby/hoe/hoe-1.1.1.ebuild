# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-1.1.1.ebuild,v 1.2 2006/12/04 20:01:21 graaff Exp $

inherit ruby gems

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.4
	>=dev-ruby/rake-0.7.1
	>=dev-ruby/rubyforge-0.3.0"
