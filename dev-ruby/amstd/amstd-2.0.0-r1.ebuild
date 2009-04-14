# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amstd/amstd-2.0.0-r1.ebuild,v 1.16 2009/04/14 17:14:14 graaff Exp $

inherit ruby

DESCRIPTION="Ruby utility collection by Minero Aoki"
HOMEPAGE="http://www.loveruby.net/en/amstd.html"
SRC_URI="http://www.loveruby.net/archive/amstd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"

IUSE=""
USE_RUBY="ruby18"
DEPEND="virtual/ruby"
