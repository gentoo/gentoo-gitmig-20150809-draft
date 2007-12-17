# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-0.2.1.ebuild,v 1.1 2007/12/17 19:22:52 graaff Exp $

inherit ruby gems

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-ruby/hpricot
	dev-ruby/activesupport
	>=dev-ruby/hoe-1.3.0"
