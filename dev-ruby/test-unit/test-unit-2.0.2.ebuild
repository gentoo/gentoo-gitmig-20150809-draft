# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.0.2.ebuild,v 1.2 2009/01/18 10:12:24 flameeyes Exp $

inherit ruby

DESCRIPTION="Test::Unit for Ruby 1.9"
HOMEPAGE="http://test-unit.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	doc? ( dev-ruby/rake
		dev-ruby/hoe )"
#	test? ( dev-ruby/rake
#		dev-ruby/hoe
#		dev-ruby/zentest )"
RDEPEND=""

USE_RUBY="any"

src_compile() {
	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

src_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"

	${RUBY} test/run-test.rb || die "testsuite failed"
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/{TODO,README.txt,History.txt} || die "dodoc failed"
}
