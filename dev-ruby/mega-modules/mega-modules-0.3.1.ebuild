# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mega-modules/mega-modules-0.3.1.ebuild,v 1.3 2006/12/29 16:54:46 pclouds Exp $

inherit ruby gems

MY_P="${P/-modules/}"

USE_RUBY="ruby18"
DESCRIPTION="Ruby's Massive Class Collection"
HOMEPAGE="http://mega.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"

IUSE=""
DEPEND="dev-ruby/nano-methods"

S="${WORKDIR}/${MY_P}"
