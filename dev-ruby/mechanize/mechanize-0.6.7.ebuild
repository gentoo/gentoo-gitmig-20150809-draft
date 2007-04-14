# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mechanize/mechanize-0.6.7.ebuild,v 1.1 2007/04/14 03:11:05 robbat2 Exp $

inherit ruby gems

DESCRIPTION="The Mechanize library is used for automating interaction with websites."
HOMEPAGE="http://mechanize.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

USE_RUBY="ruby18"

DEPEND="dev-ruby/hpricot
		>=dev-lang/ruby-1.8.2"
