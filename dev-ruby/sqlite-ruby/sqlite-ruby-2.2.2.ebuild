# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-2.2.2.ebuild,v 1.3 2004/11/20 12:00:57 fmccor Exp $

inherit ruby

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/1901/${P}.tar.bz2"

KEYWORDS="~x86 ppc ~sparc"
SLOT="0"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="=dev-db/sqlite-2*"

src_compile() {
	mkdir build
	cp ext/extconf.rb ext/sqlite-api.c build
	cp -r lib build
	cd build
	ruby extconf.rb || die "ruby extconf.rb failed"
	make || die "make failed"
}

src_install() {
	cd build
	make DESTDIR=${D} install || die "make install failed"
	cd ${S}
	erubydoc
}

src_test() {
	cd test
	ruby tests.rb || die "tests.rb failed"
}
