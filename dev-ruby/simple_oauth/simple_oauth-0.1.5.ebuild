# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/simple_oauth/simple_oauth-0.1.5.ebuild,v 1.1 2011/09/19 19:38:32 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="doc:yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem

DESCRIPTION="Simply builds and verifies OAuth headers."
HOMEPAGE="https://github.com/laserlemon/simple_oauth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "test? ( virtual/ruby-test-unit dev-ruby/mocha )"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' -e '/[Ss]imple[Cc]ov/d' -e '/turn/d' Rakefile test/helper.rb || die
}
