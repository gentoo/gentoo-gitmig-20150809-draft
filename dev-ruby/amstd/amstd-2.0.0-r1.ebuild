# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amstd/amstd-2.0.0-r1.ebuild,v 1.3 2004/04/10 08:37:26 usata Exp $

inherit ruby

DESCRIPTION="Ruby utility collection by Minero Aoki"
HOMEPAGE="http://www.loveruby.net/en/amstd.html"
SRC_URI="http://www.loveruby.net/archive/amstd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~hppa ~mips ~sparc x86"

IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"
