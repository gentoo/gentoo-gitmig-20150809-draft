# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite3-ruby/sqlite3-ruby-1.3.4.ebuild,v 1.2 2011/12/31 20:53:07 grobian Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc faq"
RUBY_FAKEGEM_EXTRADOC="API_CHANGES.rdoc README.rdoc ChangeLog.cvs CHANGELOG.rdoc"

RUBY_FAKEGEM_NAME="sqlite3"

inherit multilib ruby-fakegem

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}
	=dev-db/sqlite-3*"
DEPEND="${DEPEND}
	=dev-db/sqlite-3*"

ruby_add_bdepend "
	dev-ruby/rake-compiler
	dev-ruby/hoe
	test? ( virtual/ruby-test-unit )
	doc? ( dev-ruby/redcloth )"

all_ruby_prepare() {
	# We remove the vendor_sqlite3 rake task because it's used to
	# bundle SQlite3 which we definitely don't want.
	rm tasks/vendor_sqlite3.rake || die

	sed -i -e 's:, HOE.spec::' -e '/task :test/d' tasks/native.rake || die
}

each_ruby_configure() {
	${RUBY} -Cext/sqlite3 extconf.rb || die
}

each_ruby_compile() {
	# TODO: not sure what happens with jruby

	emake -Cext/sqlite3 || die
	mv ext/sqlite3/sqlite3_native$(get_modname) lib/sqlite3/ || die
}

all_ruby_compile() {
	all_fakegem_compile

	if use doc; then
		rake faq || die "rake faq failed"
	fi
}

each_ruby_install() {
	each_fakegem_install
}
