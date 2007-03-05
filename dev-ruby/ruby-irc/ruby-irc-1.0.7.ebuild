# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-irc/ruby-irc-1.0.7.ebuild,v 1.2 2007/03/05 04:16:03 tgall Exp $

inherit ruby gems

USE_RUBY="ruby18"
MY_PN="Ruby-IRC"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Ruby-IRC is a framework for connecting and comunicating with IRC servers."
HOMEPAGE="http://rubyforge.org/projects/ruby-irc"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5"
