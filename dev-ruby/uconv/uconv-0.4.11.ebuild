# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uconv/uconv-0.4.11.ebuild,v 1.1 2003/04/23 14:59:04 twp Exp $

DESCRIPTION="A module to convert ISO/IEC 10646 (Unicode) string and Japanese strings"
HOMEPAGE="http://www.yoshidam.net/Ruby.html#uconv"
SRC_URI="http://www.yoshidam.net/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/ruby-1.6.7"
S=${WORKDIR}/${PN}

src_compile() {
	cp extconf.rb extconf.rb.orig
	sed -e '/^\$CFLAGS = ""/d' extconf.rb.orig > extconf.rb
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
