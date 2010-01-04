# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-1.5.180.ebuild,v 1.2 2010/01/04 11:08:18 fauli Exp $

inherit ruby gems

DESCRIPTION="A small web framework modeled after Ruby on Rails."
HOMEPAGE="http://code.whytheluckystiff.net/camping/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="mongrel"
USE_RUBY="ruby18"

DEPEND="
	>=dev-ruby/markaby-0.5
	>=dev-ruby/metaid-1.0
	>=dev-ruby/activesupport-1.3.1"
RDEPEND="${DEPEND}
	mongrel? ( www-servers/mongrel )"
