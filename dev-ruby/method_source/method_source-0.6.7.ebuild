# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/method_source/method_source-0.6.7.ebuild,v 1.1 2011/12/18 17:53:34 graaff Exp $

EAPI=4
# jruby crashes on parsing the metadata.
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

RUBY_FAKEGEM_GEMSPEC="method_source.gemspec"

inherit ruby-fakegem

DESCRIPTION="Retrieve the source code for a method."
HOMEPAGE="http://github.com/banister/method_source"
IUSE=""
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64"

ruby_add_bdepend "test? ( >=dev-ruby/bacon-1.1.0 )"

ruby_add_rdepend ">=dev-ruby/ruby_parser-2.3.1"

each_ruby_test() {
	${RUBY} -I. -S bacon -k test/test.rb || die "Tests failed."
}
