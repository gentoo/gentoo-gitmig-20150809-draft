# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/log_buddy/log_buddy-0.7.0.ebuild,v 1.1 2012/05/13 06:14:00 graaff Exp $

EAPI="4"

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.markdown examples.rb"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem eutils

DESCRIPTION="Log statements along with their name easily."
HOMEPAGE="https://github.com/relevance/log_buddy"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "
	test? (
		dev-ruby/rspec:2
		>=dev-ruby/mocha-0.9
	)"

all_ruby_prepare() {
	rm Gemfile || die
}

each_ruby_test() {
	${RUBY} -S rspec spec || die
}
