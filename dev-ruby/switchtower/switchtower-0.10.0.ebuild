# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/switchtower/switchtower-0.10.0.ebuild,v 1.2 2006/01/09 13:02:35 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A distributed application deployment system"
HOMEPAGE="http://rubyforge.org/projects/switchtower/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/net-ssh-1.0.5"
