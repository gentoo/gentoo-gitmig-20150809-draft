# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.14.ebuild,v 1.1 2003/09/07 03:11:16 agriffis Exp $

IUSE=""

inherit ruby

DESCRIPTION="A multipurpose documentation format for Ruby"
HOMEPAGE="http://www2.pos.to/~tosh/ruby/rdtool/en/index.html"
SRC_URI="http://www2.pos.to/~tosh/ruby/rdtool/archive/${P}.tar.gz"
LICENSE="Ruby GPL-1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.8.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:^BIN_DIR = :&$(DESTDIR):' \
	       -e 's:^SITE_RUBY = :&$(DESTDIR):' rdtoolconf.rb \
		|| die "sed failed"
	mv rdtoolconf.rb extconf.rb
}

src_install() {
	dodir /usr/bin
	ruby_src_install
}
