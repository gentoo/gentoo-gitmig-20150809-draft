# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-1.0.ebuild,v 1.1 2003/06/26 16:49:39 twp Exp $

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://sqlite-ruby.sourceforge.net/"
SRC_URI="mirror://sourceforge/sqlite-ruby/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6.2
	>=dev-db/sqlite-2.8.3"
S=${WORKDIR}/sqlite

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall
}
