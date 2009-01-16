# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit/test-unit-2.0.2.ebuild,v 1.1 2009/01/16 19:08:56 flameeyes Exp $

inherit ruby

DESCRIPTION="Test::Unit for Ruby 1.9"
HOMEPAGE="http://test-unit.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

DEPEND="
	doc? ( dev-ruby/rake
		dev-ruby/hoe )
	test? ( dev-ruby/rake
		dev-ruby/hoe
		dev-ruby/zentest )"
RDEPEND=""

USE_RUBY="any"

src_compile() {
	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

src_test() {
	rake audit || die "rake audit failed"
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/{TODO,README.txt,History.txt} || die "dodoc failed"
}
