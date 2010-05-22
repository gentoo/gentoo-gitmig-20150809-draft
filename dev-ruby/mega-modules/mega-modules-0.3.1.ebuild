# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mega-modules/mega-modules-0.3.1.ebuild,v 1.4 2010/05/22 15:23:06 flameeyes Exp $

inherit ruby gems

MY_P="${P/-modules/}"

USE_RUBY="ruby18"
DESCRIPTION="Ruby's Massive Class Collection"
HOMEPAGE="http://mega.rubyforge.org/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"

IUSE=""
DEPEND="dev-ruby/nano-methods"

S="${WORKDIR}/${MY_P}"
