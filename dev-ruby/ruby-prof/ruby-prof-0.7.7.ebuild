# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-prof/ruby-prof-0.7.7.ebuild,v 1.1 2010/01/15 01:01:07 flameeyes Exp $

EAPI=2

# jruby → not compatible, since it uses an extension
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="README CHANGES"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="A module for profiling Ruby code"
HOMEPAGE="http://rubyforge.org/projects/ruby-prof/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

all_ruby_prepare() {
	# The thread testing in 0.7.5 and earlier versions is broken, it
	# has to be tested for the next versions, since upstream is
	# looking for a solution. The problem is that it's _very_
	# timing-dependent.
	rm "${S}"/test/thread_test.rb \
		|| die "unable to remove broken test unit"
	sed -i -e '/thread_test/d' \
		test/test_suite.rb || die "unable to remove broken test reference"
}

each_ruby_compile() {
	pushd ext
	${RUBY} extconf.rb || die "extconf.rb failed"
	# gem ships with prebuild files
	emake clean || die "clean failed"
	emake || die "build failed"
	popd

	cp ext/*.so lib || die "copy of extension failed"
}

all_ruby_install() {
	all_fakegem_install

	for dir in examples rails rails/example rails/environment; do
		docinto "$dir"
		dodoc "$dir"/* || die "dodoc $dir failed"
	done
}
