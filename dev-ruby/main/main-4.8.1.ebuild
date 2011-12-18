# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/main/main-4.8.1.ebuild,v 1.1 2011/12/18 14:45:50 graaff Exp $

EAPI=4
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README TODO"

inherit ruby-fakegem

DESCRIPTION="A class factory and dsl for generating command line programs real quick."
HOMEPAGE="http://rubyforge.org/projects/codeforpeople"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

# Has ~ dependencies on minor versions in gemspec and main.rb. Fix or
# make explicit here?
ruby_add_rdepend ">=dev-ruby/chronic-0.6.2
	>=dev-ruby/fattr-2.2.0
	>=dev-ruby/arrayfields-4.7.4
	>=dev-ruby/map-5.1.0"

all_ruby_install() {
	all_fakegem_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r samples
	fi
}
