# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth/oauth-0.4.1.ebuild,v 1.1 2010/06/25 21:04:16 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="HISTORY README.rdoc TODO"

inherit ruby-fakegem

DESCRIPTION="A RubyGem for implementing both OAuth clients and servers."
HOMEPAGE="http://oauth.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_PATCHES=( "${P}-optional-tests.patch" )

ruby_add_bdepend "test? ( virtual/ruby-test-unit dev-ruby/actionpack dev-ruby/mocha )"
