# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-3.0.1.ebuild,v 1.1 2005/01/26 16:32:31 citizen428 Exp $

inherit ruby

MY_P="RedCloth-${PV}"

DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/ruby/redcloth/"
SRC_URI="http://rubyforge.org/frs/download.php/2679/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="any"
DEPEND="virtual/ruby"

S=${WORKDIR}/${MY_P}

src_compile() {
	ruby install.rb config --prefix=/usr || die "ruby install.rb config failed"
	ruby install.rb setup || die "ruby install.rb setup failed"
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die "ruby install.rb config failed"
	ruby install.rb install || die "ruby install.rb install failed"
	dodoc doc/CHANGELOG doc/README doc/REFERENCE
}
