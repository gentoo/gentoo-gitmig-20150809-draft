# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-amazon/ruby-amazon-0.8.2.ebuild,v 1.4 2004/09/30 09:04:37 citizen428 Exp $

inherit ruby

IUSE="geoip"

DESCRIPTION="A Ruby interface to Amazon web services"
HOMEPAGE="http://www.caliban.org/ruby/ruby-amazon.shtml"
SRC_URI="http://www.caliban.org/files/ruby/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/ruby
	geoip? ( >=dev-ruby/net-geoip-0.06 )"
USE_RUBY="any"

src_compile() {
	ruby setup.rb config || die
	ruby setup.rb setup || die
}

src_install() {
	ruby setup.rb config --prefix=${D}/usr || die
	ruby setup.rb install || die
}
