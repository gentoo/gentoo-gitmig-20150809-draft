# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uuidtools/uuidtools-1.0.7.ebuild,v 1.3 2010/10/09 07:46:17 graaff Exp $

inherit ruby

DESCRIPTION="Simple library to generate UUIDs"
HOMEPAGE="http://uuidtools.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test doc"

DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )
	test? ( >=dev-ruby/rspec-1.0.8 )"
RDEPEND=""

USE_RUBY="ruby18"

src_unpack() {
	unpack ${A}

	find . -name '._*.rb' -delete || die "unable to remove mac files"
}

src_compile() {
	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

src_test() {
	rake spec:normal || die "rake spec failed"
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/CHANGELOG "${S}"/README || die "dodoc failed"
}
