# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/awesome_print/awesome_print-0.2.1.ebuild,v 1.1 2010/09/24 13:36:38 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby library that pretty prints Ruby objects in full color with proper indentation."
HOMEPAGE="http://github.com/michaeldv/awesome_print"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/rspec-1.2.9:0 )"

all_ruby_prepare() {
	# Remove unneeded check, we have our own dependencies set up.
	sed -i -e '/check_dependencies/d' Rakefile || die
}
