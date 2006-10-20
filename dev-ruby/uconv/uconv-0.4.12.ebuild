# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uconv/uconv-0.4.12.ebuild,v 1.10 2006/10/20 21:33:58 agriffis Exp $

inherit ruby

DESCRIPTION="A module to convert ISO/IEC 10646 (Unicode) string and Japanese strings"
HOMEPAGE="http://www.yoshidam.net/Ruby.html#uconv"
SRC_URI="http://www.yoshidam.net/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc ppc64 x86"
IUSE=""
DEPEND="virtual/ruby"
USE_RUBY="ruby16 ruby18 ruby19"
S=${WORKDIR}/${PN}

src_compile() {
	cp extconf.rb extconf.rb.orig
	sed -e '/^\$CFLAGS = ""/d' extconf.rb.orig > extconf.rb
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README*
}
