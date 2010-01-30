# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-2.2.3-r2.ebuild,v 1.1 2010/01/30 09:15:01 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

RUBY_PATCHES=( "${P}-19compat.patch" )

DEPEND="=dev-db/sqlite-2*"

each_ruby_configure() {
	pushd ext
	${RUBY} extconf.rb || die "Configuration failed."
	popd
}

each_ruby_compile() {
	pushd ext
	emake || die "Compilation failed."
	popd
	cp ext/sqlite_api.so lib || die "Unable to cp shared library."
}

each_ruby_test() {
	${RUBY} test/tests.rb || die "Tests failed."
}

all_ruby_install() {
	all_fakegem_install

	dohtml -r doc/faq
}
