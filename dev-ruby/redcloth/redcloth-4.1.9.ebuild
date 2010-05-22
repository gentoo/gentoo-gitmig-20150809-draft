# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-4.1.9.ebuild,v 1.5 2010/05/22 14:29:25 flameeyes Exp $

inherit ruby gems

MY_P="RedCloth-${PV}"
DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/ruby/redcloth/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

USE_RUBY="ruby18"

S=${WORKDIR}/${MY_P}
