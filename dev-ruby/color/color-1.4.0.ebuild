# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color/color-1.4.0.ebuild,v 1.5 2009/04/14 19:57:57 graaff Exp $

inherit gems

DESCRIPTION="Colour management with Ruby"
HOMEPAGE="http://color.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/hoe-1.3.0
	>=dev-ruby/archive-tar-minitar-0.5.1"

RDEPEND="${DEPEND}"
