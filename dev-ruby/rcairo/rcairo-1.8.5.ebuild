# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.5.ebuild,v 1.1 2010/09/18 13:57:56 graaff Exp $

EAPI=2

# ruby19 → fails, and even crashes Ruby
# jruby → cannot work, it's a compiled extension
USE_RUBY="ruby18"

# Documentation depends on files that are not distributed.
RUBY_FAKEGEM_TASK_DOC=""

# Depends on test-unit-2 which is currently masked.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="AUTHORS NEWS"

inherit multilib ruby-fakegem

IUSE="svg"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="mirror://rubygems/cairo-${PV}.gem"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"

# force identical svg dependency between the two so that you're forced
# to rebuild this when changing it on cairo, this is because we cannot
# enable/disable svg, but it'll follow what the original cairo
# supports.
RDEPEND="${RDEPEND}
	>=x11-libs/cairo-1.2.0[svg=]"
DEPEND="${DEPEND}
	>=x11-libs/cairo-1.2.0[svg=]
	dev-util/pkgconfig"

ruby_add_bdepend "test? ( >=dev-ruby/test-unit-2.1.0-r1:2 )"

all_ruby_prepare() {
	# it fails, badly, as it expects the .pc to be frozen in time,
	# which it isn't...
	rm test/test_pkg_config.rb || die

	# fix two strange assert calls
	sed -i \
		-e 's:assert_true(:assert(:' \
		-e 's:assert_false(:assert(!:' \
		test/test_exception.rb \
		test/test_constants.rb || die
echo
}

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake || die "make failed"

	# again, try to make it more standard, to install it more easily.
	cp ext/cairo/cairo$(get_modname) lib/ || die
}

each_ruby_test() {
	# don't rely on the Rakefile because it's a mess to load with
	# their hierarchy, do it manually.
	${RUBY} -Ilib -r ./test/cairo-test-utils.rb -S \
		testrb-2 ./test/test_*.rb \
		|| die "tests failed"
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/samples
	doins -r samples/* || die "Cannot install sample files."
}
