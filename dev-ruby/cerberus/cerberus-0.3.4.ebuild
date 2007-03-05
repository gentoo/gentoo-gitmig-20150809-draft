# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cerberus/cerberus-0.3.4.ebuild,v 1.2 2007/03/05 04:42:18 tgall Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Continuous Integration tool for ruby projects"
HOMEPAGE="http://rubyforge.org/projects/cerberus"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/actionmailer-1.3
		>=dev-ruby/xmpp4r-0.3-r1
		>=dev-ruby/ruby-irc-1.0.7
		>=dev-lang/ruby-1.8.5"
