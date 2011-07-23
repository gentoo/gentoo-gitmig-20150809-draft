# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack-test/rack-test-0.5.7.ebuild,v 1.3 2011/07/23 07:28:25 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit versionator ruby-fakegem

DESCRIPTION="Rack::Test is a small, simple testing API for Rack apps."
HOMEPAGE="http://github.com/brynary/rack-test"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

ruby_add_rdepend '>=dev-ruby/rack-1.0'
ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/sinatra )"

all_ruby_prepare() {
	# Remove Bundler related code.
	rm Gemfile Gemfile.lock || die "Unable to clean unneeded Bundler items."
}
