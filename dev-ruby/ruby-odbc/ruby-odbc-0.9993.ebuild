# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-odbc/ruby-odbc-0.9993.ebuild,v 1.2 2006/10/06 11:47:55 nixnut Exp $

inherit ruby
DESCRIPTION="RubyODBC - For accessing ODBC data sources from the Ruby language"
HOMEPAGE="http://www.ch-werner.de/rubyodbc/"
SRC_URI="http://www.ch-werner.de/rubyodbc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
USE_RUBY="ruby18"
IUSE=""

DEPEND="virtual/ruby
	>=dev-db/unixODBC-2.0.6"

src_compile() {
	ruby extconf.rb
	emake
}

src_install() {
	ruby_src_install
	dodoc LICENSE README
}
