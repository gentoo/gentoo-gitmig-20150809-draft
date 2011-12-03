# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-freedb/ruby-freedb-0.5-r1.ebuild,v 1.3 2011/12/03 11:56:59 hwoarang Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="A Ruby library to access cddb/freedb servers"
HOMEPAGE="http://ruby-freedb.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/69/${P}.tar.gz"
LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~sparc x86"
IUSE=""

each_ruby_configure() {
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die
}

all_ruby_install() {
	dodoc CHANGELOG README || die
	dohtml -r doc/* || die
	insinto /usr/share/doc/${PF}
	doins -r examples || die
}
