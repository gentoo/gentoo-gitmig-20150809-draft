# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yajl-ruby/yajl-ruby-0.7.8.ebuild,v 1.1 2010/10/02 13:07:01 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

# Needs jeweler for documentation building
RUBY_FAKEGEM_TASK_DOC=""

inherit multilib ruby-fakegem

DESCRIPTION="Ruby C bindings to the Yajl JSON stream-based parser library"
HOMEPAGE="http://github.com/brianmario/yajl-ruby"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/yajl"
DEPEND="${RDEPEND}"

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}" || die "make extension failed"
	cp ext/yajl_ext$(get_modname) lib || die
}
