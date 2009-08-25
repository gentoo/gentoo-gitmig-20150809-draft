# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uuidtools/uuidtools-2.0.0.ebuild,v 1.1 2009/08/25 17:46:33 graaff Exp $

inherit ruby eutils

DESCRIPTION="Simple library to generate UUIDs"
HOMEPAGE="http://uuidtools.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )
	test? ( >=dev-ruby/rspec-1.0.8 )"
RDEPEND=""

USE_RUBY="ruby18 ruby19"

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
	for ruby in $USE_RUBY; do
		[[ -n `type -p $ruby` ]] || continue
		$ruby $(type -p rake) spec:normal || die "testsuite failed"
	done
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/CHANGELOG "${S}"/README || die "dodoc failed"
}
