# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-cli/mixlib-cli-1.2.2.ebuild,v 1.1 2011/09/11 06:31:27 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Mixin for creating command line applications"
HOMEPAGE="http://github.com/opscode/mixlib-cli"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_test() {
	${RUBY} -S spec spec || die "Tests failed."
}
