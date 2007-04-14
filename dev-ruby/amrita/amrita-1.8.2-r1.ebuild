# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amrita/amrita-1.8.2-r1.ebuild,v 1.19 2007/04/14 05:59:18 graaff Exp $

inherit ruby

IUSE=""

DESCRIPTION="A HTML/XHTML template library for Ruby"
HOMEPAGE="http://www.brain-tokyo.jp/research/amrita/index.html"
SRC_URI="http://www.brain-tokyo.jp/research/amrita/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby18 ruby19"
KEYWORDS="alpha hppa ia64 mips ppc ppc64 sparc x86"
DEPEND=">=dev-lang/ruby-1.8.0"
