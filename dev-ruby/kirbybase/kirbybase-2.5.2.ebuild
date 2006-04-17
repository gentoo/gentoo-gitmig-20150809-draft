# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kirbybase/kirbybase-2.5.2.ebuild,v 1.3 2006/04/17 23:18:57 caleb Exp $

inherit ruby gems

IUSE=""

MY_P="KirbyBase-${PV}"

DESCRIPTION="A simple, pure-Ruby, flat-file database management system"
HOMEPAGE="http://www.netpromi.com/kirbybase_ruby.html"
SRC_URI="http://www.netpromi.com/files/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 x86"

DEPEND=">=dev-lang/ruby-1.8.2"
USE_RUBY="ruby18"

S=${WORKDIR}/${P/-/}
