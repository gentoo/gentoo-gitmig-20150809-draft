# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/msgpack/msgpack-0.3.6.ebuild,v 1.1 2010/04/04 08:43:49 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Binary-based efficient data interchange format for ruby binding"
HOMEPAGE="http://msgpack.sourceforge.jp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_configure() {
	pushd ext
	${RUBY} extconf.rb || die "Configuration of extension failed."
	popd
}

each_ruby_compile() {
	pushd ext
	emake || die
	popd
}

each_ruby_test() {
	${RUBY} test/msgpack_test.rb
}

each_ruby_install() {
	mkdir lib || die "Unable to make lib directory."
	cp ext/msgpack.so lib/ || die "Unable to install msgpack library."

	each_fakegem_install
}
