# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-svg/ruby-svg-1.0.3.ebuild,v 1.1 2003/12/15 17:28:55 usata Exp $

DESCRIPTION="Ruby SVG Generator"
HOMEPAGE="http://ruby-svg.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/ruby-svg/2288/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6.5"
S="${WORKDIR}/${P}"

src_install() {

	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb setup || die
	ruby install.rb install || die
	dodoc README* || die
}
