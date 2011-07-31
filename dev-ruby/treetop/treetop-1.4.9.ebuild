# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/treetop/treetop-1.4.9.ebuild,v 1.5 2011/07/31 16:55:33 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18"
# jruby fails tests, not investigated yet.

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Treetop is a language for describing languages."
HOMEPAGE="http://treetop.rubyforge.org/"
LICENSE="Ruby"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rr dev-ruby/rspec:0 dev-ruby/ruby-debug dev-ruby/activesupport )"
ruby_add_rdepend ">=dev-ruby/polyglot-0.3.1"

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/* || die "Failed installing example files."
}
