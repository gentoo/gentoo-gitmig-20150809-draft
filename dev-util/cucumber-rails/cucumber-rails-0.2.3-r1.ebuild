# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber-rails/cucumber-rails-0.2.3-r1.ebuild,v 1.1 2010/01/15 09:57:37 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="-f tasks/rspec.rake spec"
RUBY_FAKEGEM_EXTRAINSTALL="generators"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios for Rails"
HOMEPAGE="http://github.com/aslakhellesoy/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RUBY_PATCHES=( "${P}-fix-broken-logic.patch" )

ruby_add_bdepend test dev-ruby/rspec

ruby_add_rdepend ">=dev-util/cucumber-0.5.1"

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_doins VERSION
}

all_ruby_install() {
	dodoc History.txt README.rdoc
}
