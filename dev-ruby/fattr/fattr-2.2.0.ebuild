# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fattr/fattr-2.2.0.ebuild,v 1.1 2010/11/17 06:30:04 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="fattr.rb is a \"fatter attr\" for ruby."
HOMEPAGE="http://rubyforge.org/projects/codeforpeople/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

each_ruby_test() {
	${RUBY} test/fattr_test.rb || die "Tests failed."
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r samples
}
