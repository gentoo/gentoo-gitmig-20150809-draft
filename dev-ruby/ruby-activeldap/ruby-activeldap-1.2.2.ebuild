# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-activeldap/ruby-activeldap-1.2.2.ebuild,v 1.4 2011/01/10 17:55:12 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES README TODO"
RUBY_FAKEGEM_EXTRAINSTALL="data po rails rails_generators"
RUBY_FAKEGEM_NAME="activeldap"

inherit ruby-fakegem

MY_P="${P/ruby-/}"
DESCRIPTION="Ruby/ActiveLDAP provides an activerecord inspired object oriented interface to LDAP"
HOMEPAGE="http://ruby-activeldap.rubyforge.org/doc/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-macos"
IUSE=""

# Most tests require a live LDAP server to run.
RESTRICT="test"

ruby_add_bdepend "dev-ruby/hoe"
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "
	=dev-ruby/activerecord-2.3*
	~dev-ruby/locale-2.0.5
	=dev-ruby/ruby-gettext-2.1.0*
	=dev-ruby/gettext_activerecord-2.1.0*
	>=dev-ruby/ruby-ldap-0.8.2"

all_ruby_prepare() {
	# Make activeldap more lenient towards newer Rails versions.
	sed -i -e "s/= 2.3.8/~>2.3.5/" lib/active_ldap.rb || die
}

each_ruby_test() {
	# Tests use test-unit-2 which is currently masked in tree.
	# Version 2.0.6 is bundled so use that for now.
	RUBYLIB=test-unit/lib ${RUBY} -S rake test || die "Tests failed."
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
