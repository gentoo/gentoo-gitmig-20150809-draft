# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amatch/amatch-0.2.1.ebuild,v 1.2 2005/10/27 20:43:39 hansmi Exp $

inherit ruby

USE_RUBY="ruby18 ruby19"

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://amatch.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/6031/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
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

