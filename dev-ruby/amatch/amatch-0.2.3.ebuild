# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amatch/amatch-0.2.3.ebuild,v 1.4 2009/10/05 15:45:21 armin76 Exp $

inherit ruby

USE_RUBY="ruby18"

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://amatch.rubyforge.org"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ia64 ~ppc ppc64 x86"
IUSE=""

DEPEND="virtual/ruby"

src_compile() {
	ruby install.rb config || die 'install.rb config failed'
	ruby install.rb setup || die 'install.rb setup failed'
}

src_install() {
	ruby install.rb config --prefix="${D}"/usr || die 'install.rb config failed'
	ruby install.rb install || die 'install.rb install failed'
	dodoc README.en
}
