# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xlib/ruby-xlib-0.6.15.ebuild,v 1.1 2005/05/17 19:46:15 agriffis Exp $

inherit ruby
USE_RUBY="ruby16 ruby18 ruby19"

DESCRIPTION="call Xlib functions from ruby"
HOMEPAGE="http://www.moriq.com/ruby/xlib/"
SRC_URI="http://www.moriq.com/ruby/archive/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/x11"

PATCHES="${FILESDIR}/ruby-xlib-0.6.15-gcc.patch"
