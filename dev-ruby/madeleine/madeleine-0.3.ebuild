# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/madeleine/madeleine-0.3.ebuild,v 1.1 2003/06/26 17:06:30 twp Exp $

DESCRIPTION="A Ruby implementation of object prevalence"
HOMEPAGE="http://madeleine.sourceforge.net/"
SRC_URI="mirror://sourceforge/madeleine/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.8*"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
}
