# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/madeleine/madeleine-0.3.ebuild,v 1.5 2004/06/25 01:53:57 agriffis Exp $

DESCRIPTION="A Ruby implementation of object prevalence"
HOMEPAGE="http://madeleine.sourceforge.net/"
SRC_URI="mirror://sourceforge/madeleine/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
DEPEND="|| ( >=dev-lang/ruby-1.8.0 dev-lang/ruby-cvs )"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
}
