# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyfilter/rubyfilter-0.12.ebuild,v 1.4 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby

DESCRIPTION="A mail handling library for Ruby"
HOMEPAGE="http://www.lickey.com/rubyfilter/"
SRC_URI="http://www.lickey.com/rubyfilter/download/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
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
