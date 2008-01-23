# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color/color-1.4.0.ebuild,v 1.2 2008/01/23 02:29:56 mr_bones_ Exp $

inherit gems

DESCRIPTION="Colour management with Ruby"
HOMEPAGE="http://color.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ruby/hoe-1.3.0
	>=dev-ruby/archive-tar-minitar-0.5.1"

RDEPEND="${DEPEND}"
