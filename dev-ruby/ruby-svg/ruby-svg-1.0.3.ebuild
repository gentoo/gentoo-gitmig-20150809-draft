# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-svg/ruby-svg-1.0.3.ebuild,v 1.5 2004/07/14 22:15:52 agriffis Exp $

inherit ruby

DESCRIPTION="Ruby SVG Generator"
HOMEPAGE="http://ruby-svg.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/ruby-svg/2288/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
USE_RUBY="any"
IUSE=""
DEPEND="virtual/ruby"

src_install() {

	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb setup || die
	ruby install.rb install || die
	dodoc README* || die
}
