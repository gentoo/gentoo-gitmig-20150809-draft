# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-4.2.2.ebuild,v 1.2 2010/02/13 20:17:41 armin76 Exp $

inherit ruby gems

MY_P="RedCloth-${PV}"
DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/ruby/redcloth/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

USE_RUBY="ruby18 ruby19"

S=${WORKDIR}/${MY_P}
