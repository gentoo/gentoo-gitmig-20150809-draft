# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nano-methods/nano-methods-0.8.2.ebuild,v 1.3 2007/03/14 03:26:27 tgall Exp $

inherit ruby gems

MY_P="${P/-methods/}"

USE_RUBY="ruby18"
DESCRIPTION="Ruby's Atomic Library"
HOMEPAGE="http://nano.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86"

IUSE=""
DEPEND="virtual/ruby"

S="${WORKDIR}/${MY_P}"
