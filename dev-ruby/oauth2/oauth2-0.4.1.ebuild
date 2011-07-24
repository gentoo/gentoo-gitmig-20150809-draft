# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth2/oauth2-0.4.1.ebuild,v 1.2 2011/07/24 20:09:44 tomka Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC="rerdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth gem."
HOMEPAGE="http://github.com/intridea/oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/faraday-0.6.1 >=dev-ruby/multi_json-0.0.5"
ruby_add_bdepend test ">=dev-ruby/rspec-2.5.0:2"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e "/[Bb]undler/d" -e "/[Ss]imple[Cc]ov/d" spec/spec_helper.rb || die
}

each_ruby_test() {
	${RUBY} -S rspec spec || die
}
