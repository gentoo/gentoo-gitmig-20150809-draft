# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-0.9.8.ebuild,v 1.1 2010/07/19 10:48:56 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="History Notes README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/httparty-0.5.0
	>=dev-ruby/oauth-0.4.1
	>=dev-ruby/hashie-0.2.0
	>=dev-ruby/yajl-ruby-0.7.0
	>=dev-ruby/matchy-0.4.0"

# Tests depend on an older version of matchy that we do not have packaged.
RESTRICT="test"

#ruby_add_bdepend "test? (
#	dev-ruby/jeweler
#	>=dev-ruby/fakeweb-1.2.0
#	>=dev-ruby/mocha-0.9.0
#	>=dev-ruby/shoulda-2.10.0"

all_ruby_prepare() {
	sed -i -e '/check_dependencies/d' Rakefile || die "Unable to remove dependency check."
}
