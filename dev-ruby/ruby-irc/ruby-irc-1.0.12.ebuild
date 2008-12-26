# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-irc/ruby-irc-1.0.12.ebuild,v 1.1 2008/12/26 15:52:16 graaff Exp $

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
