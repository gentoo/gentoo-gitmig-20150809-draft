# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nano-methods/nano-methods-0.8.2.ebuild,v 1.5 2010/05/22 15:28:21 flameeyes Exp $

inherit ruby gems

MY_P="${P/-methods/}"

USE_RUBY="ruby18"
DESCRIPTION="Ruby's Atomic Library"
HOMEPAGE="http://nano.rubyforge.org/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86"

IUSE=""

S="${WORKDIR}/${MY_P}"
