# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shout/ruby-shout-2.0.ebuild,v 1.6 2006/10/20 11:27:31 flameeyes Exp $

inherit ruby

DESCRIPTION="A Ruby interface to libshout2"
HOMEPAGE="http://www.dingoskidneys.com/~jaredj/shout.html"
SRC_URI="http://www.dingoskidneys.com/~jaredj/downloads/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/ruby
	>=media-libs/libshout-2.0"
USE_RUBY="ruby16 ruby18 ruby19"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README example.rb
	docinto doc
	dodoc doc/*
}
