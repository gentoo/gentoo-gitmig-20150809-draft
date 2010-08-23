# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heckle/heckle-1.4.3-r2.ebuild,v 1.1 2010/08/23 13:56:30 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

inherit ruby-fakegem

DESCRIPTION="Unit Test Sadism"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/ruby2ruby-1.1.6
	>=dev-ruby/parsetree-2.0.0
	>=dev-ruby/zentest-3.5.2"
ruby_add_bdepend "
	doc? ( dev-ruby/hoe )
	test? (
		dev-ruby/hoe
		virtual/ruby-test-unit
	)"

src_compile() {
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"
	ruby-ng_src_compile
}

src_test() {
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"
	ruby-ng_src_test
}
