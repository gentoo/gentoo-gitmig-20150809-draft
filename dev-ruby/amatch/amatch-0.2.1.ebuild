# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amatch/amatch-0.2.1.ebuild,v 1.9 2008/03/31 14:46:12 pclouds Exp $

inherit ruby

USE_RUBY="ruby18 ruby19"

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://amatch.rubyforge.org"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ia64 ~ppc ppc64 x86"
IUSE=""

DEPEND="virtual/ruby"

src_compile() {
	ruby install.rb config || die 'install.rb config failed'
	ruby install.rb setup || die 'install.rb setup failed'
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die 'install.rb config failed'
	ruby install.rb install || die 'install.rb install failed'
	dodoc README.en
}
