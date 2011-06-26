# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth/oauth-0.4.5.ebuild,v 1.1 2011/06/26 07:12:23 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

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
		dev-ruby/mocha
		dev-ruby/webmock )"

all_ruby_prepare() {
	# Ensure a consistent test order to avoid loading issues with e.g. rack
	sed -i -e "s/.rb']/.rb'].sort/" Rakefile || die
}
