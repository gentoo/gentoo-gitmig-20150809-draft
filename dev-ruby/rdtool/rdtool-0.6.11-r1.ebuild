# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.11-r1.ebuild,v 1.3 2003/09/07 03:11:16 agriffis Exp $

DESCRIPTION="A multipurpose documentation format for Ruby"
HOMEPAGE="http://www2.pos.to/~tosh/ruby/rdtool/en/index.html"
SRC_URI="http://www2.pos.to/~tosh/ruby/rdtool/archive/${P}.tar.gz"
LICENSE="Ruby GPL-1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/racc-1.3
	dev-ruby/amstd"
	# These are part of ruby as of 1.8.0 (06 Sep 2003 agriffis)
	# dev-ruby/optparse
	# dev-ruby/strscan

src_compile() {
	ruby rdtoolconf.rb || die
	mv Makefile Makefile.orig
	sed -e "s:^\(BIN_DIR = \)\(.*\):\\1${D}\\2:" \
		-e "s:^\(SITE_RUBY = \)\(.*\):\\1${D}\\2:" \
		Makefile.orig > Makefile
	make || die
}

src_install() {
	install -m 755 -d ${D}/usr/bin
	DESTDIR=${D} make install || die
	dodoc HISTORY README.*
}
