# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubigen/rubigen-1.5.4.ebuild,v 1.1 2010/02/26 07:02:16 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc Todo.txt"

RUBY_FAKEGEM_EXTRAINSTALL="app_generators generators rubygems_generators script test_unit_generators"

inherit ruby-fakegem

DESCRIPTION="A framework to allow Ruby applications to generate file/folder stubs."
HOMEPAGE="http://drnic.github.com/rubigen"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend test ">=dev-ruby/mocha-0.9.8
	>=dev-ruby/shoulda-2.10.3
	>=dev-ruby/hoe-2.4.0
	virtual/ruby-test-unit"

ruby_add_rdepend ">=dev-ruby/activesupport-2.3.5"

all_ruby_prepare() {
	# Remove newgem requirement from the Rakefile since it is not
	# needed for our purposes and we don't have it in CVS.
	sed -i '/newgem/d' Rakefile || die "Unable to remove unneeded newgem support."

	rm -f test/test_generate_builtin_application.rb || die "Unable to remove broken test."
}

each_ruby_test() {
	each_fakegem_test

	# Run all features not related to creating and distributing the gem itself
	${RUBY} -S cucumber features/help.feature features/rubigen_cli.feature
}
