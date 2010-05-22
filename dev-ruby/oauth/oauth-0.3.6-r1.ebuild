# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth/oauth-0.3.6-r1.ebuild,v 1.2 2010/05/22 15:32:19 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc TODO"

RUBY_FAKEGEM_EXTRAINSTALL="script"

inherit ruby-fakegem

DESCRIPTION="A RubyGem for implementing both OAuth clients and servers."
HOMEPAGE="http://oauth.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_PATCHES=( "oauth-0.3.6-newgem.patch" )

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend ">=dev-ruby/ruby-hmac-0.3.1 dev-ruby/rubigen"

all_ruby_prepare() {
	# Remove test that requires an insecure version of actionpack
	# http://github.com/mojodna/oauth/issues/#issue/12
	rm -f test/test_action_controller_request_proxy.rb || die "Unable to remove failing test."
}
