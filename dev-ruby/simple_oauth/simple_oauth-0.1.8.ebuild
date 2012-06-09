# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/simple_oauth/simple_oauth-0.1.8.ebuild,v 1.1 2012/06/09 07:00:10 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Simply builds and verifies OAuth headers."
HOMEPAGE="https://github.com/laserlemon/simple_oauth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

each_ruby_test() {
	CI=true ${RUBY} -S rspec spec || die
}
