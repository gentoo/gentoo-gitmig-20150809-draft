# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.0.2-r1.ebuild,v 1.3 2009/05/22 23:42:07 flameeyes Exp $

inherit ruby

DESCRIPTION="An improved version of the Test::Unit framework from Ruby 1.8"
HOMEPAGE="http://test-unit.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="
	doc? ( dev-ruby/rake
		dev-ruby/hoe )"
#	test? ( dev-ruby/rake
#		dev-ruby/hoe
#		dev-ruby/zentest )"
RDEPEND=""

USE_RUBY="ruby18 ruby19"

src_compile() {
	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

src_test() {
	for ruby in $USE_RUBY; do
		[[ -n `type -p $ruby` ]] || continue
		# the rake audit using dev-ruby/zentest currently fails, and we
		# just need to call the testsuite directly.
		# rake audit || die "rake audit failed"
		$ruby test/run-test.rb || die "testsuite failed"
	done
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/{TODO,README.txt,History.txt} || die "dodoc failed"
}
