# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shout/ruby-shout-2.0.ebuild,v 1.1 2004/01/31 08:36:32 usata Exp $

inherit ruby

DESCRIPTION="A Ruby interface to libshout2"
HOMEPAGE="http://www.dingoskidneys.com/~jaredj/shout.html"
SRC_URI="http://www.dingoskidneys.com/~jaredj/downloads/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/ruby-1.6
	>=media-libs/libshout-2.0"
USE_RUBY="ruby16 ruby18 ruby19"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README example.rb
	docinto doc
	dodoc doc/*
}
