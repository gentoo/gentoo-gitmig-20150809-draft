# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-0.9.12.ebuild,v 1.1 2010/10/02 12:52:19 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="HISTORY.rdoc Notes README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/httparty-0.6.1
	>=dev-ruby/oauth-0.4.3
	>=dev-ruby/hashie-0.4.0
	>=dev-ruby/multi_json-0.0.4"

ruby_add_bdepend "test? (
	>=dev-ruby/fakeweb-1.3.0
	>=dev-ruby/mocha-0.9.8
	>=dev-ruby/shoulda-2.10.0
	)"

all_ruby_prepare() {
	sed -i -e '/check_dependencies/d' Rakefile || die "Unable to remove dependency check."

	sed -i -e '/[Bb]undler/d' Rakefile || die "Unable to remove bundler code."
}
