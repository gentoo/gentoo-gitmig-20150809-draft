# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyfilter/rubyfilter-0.12.ebuild,v 1.2 2005/08/11 10:28:34 dholm Exp $

inherit ruby

DESCRIPTION="A mail handling library for Ruby"
HOMEPAGE="http://www.lickey.com/rubyfilter/"
SRC_URI="http://www.lickey.com/rubyfilter/download/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~ppc ~x86"
USE_RUBY="ruby16 ruby18"

IUSE=""
RDEPEND="dev-ruby/rubymail"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die

	dodoc NEWS README THANKS TODO
	dohtml -r doc/*
}

