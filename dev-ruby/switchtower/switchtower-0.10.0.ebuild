# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/switchtower/switchtower-0.10.0.ebuild,v 1.6 2006/10/20 22:30:52 agriffis Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A distributed application deployment system"
HOMEPAGE="http://rubyforge.org/projects/switchtower/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="ia64 x86"
IUSE=""
#RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/net-ssh-1.0.5
	>=dev-ruby/net-sftp-1.1.0"
