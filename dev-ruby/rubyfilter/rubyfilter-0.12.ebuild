# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyfilter/rubyfilter-0.12.ebuild,v 1.5 2009/06/13 08:13:43 graaff Exp $

inherit ruby

DESCRIPTION="A mail handling library for Ruby"
HOMEPAGE="http://www.lickey.com/rubyfilter/"
SRC_URI="http://www.lickey.com/rubyfilter/download/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
USE_RUBY="ruby18"

IUSE=""
RDEPEND="dev-ruby/rubymail"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix="${D}/usr" || die
	ruby install.rb install || die

	dodoc NEWS README THANKS TODO
	dohtml -r doc/*
}
