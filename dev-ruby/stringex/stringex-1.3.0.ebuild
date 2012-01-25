# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/stringex/stringex-1.3.0.ebuild,v 1.1 2012/01/25 22:13:06 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_DOC_DIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Extensions for Ruby's String class"
HOMEPAGE="http://github.com/rsl/stringex"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "
	test? (
		dev-ruby/activerecord
		dev-ruby/redcloth
	)"

each_ruby_test() {
	# rake seems to break this
	${RUBY} -Ilib -S testrb test/*_test.rb || die "tests failed"
}
