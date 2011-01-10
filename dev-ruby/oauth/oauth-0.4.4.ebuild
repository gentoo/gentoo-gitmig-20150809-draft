# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth/oauth-0.4.4.ebuild,v 1.2 2011/01/10 18:25:40 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="HISTORY README.rdoc TODO"

inherit ruby-fakegem

DESCRIPTION="A RubyGem for implementing both OAuth clients and servers."
HOMEPAGE="http://oauth.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit
		>=dev-ruby/actionpack-2.3.8:2.3
		dev-ruby/mocha )"

all_ruby_prepare() {
	# Let this test work with a wider range of rails versions, but still
	# in SLOT 2.3, and request the right version of rack for it.
	sed -i -e "s/'2.3.8'/'~>2.3.8'/" test/test_action_controller_request_proxy.rb || die

	# Ensure a consistent test order to avoid loading issues with e.g. rack
	sed -i -e "s/.rb']/.rb'].sort/" Rakefile || die
}
