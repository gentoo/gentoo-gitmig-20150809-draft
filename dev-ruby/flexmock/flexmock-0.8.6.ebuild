# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flexmock/flexmock-0.8.6.ebuild,v 1.4 2010/05/22 15:15:20 flameeyes Exp $

inherit ruby

DESCRIPTION="Simple mock object library for Ruby unit testing"
HOMEPAGE="http://${PN}.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE="doc test"

RDEPEND=""
DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )"

USE_RUBY="ruby18"

PATCHES=( "${FILESDIR}/${P}-rdoc-template.patch" )

dofakegemspec() {
	cat - > "${T}"/${P}.gemspec <<EOF
Gem::Specification.new do |s|
  s.name = "${PN}"
  s.version = "${PV}"
  s.summary = "${DESCRIPTION}"
  s.homepage = "${HOMEPAGE}"
end
EOF

	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["vendorlibdir"]' | sed -e 's:vendor_ruby:gems:')/specifications
	doins "${T}"/${P}.gemspec || die "Unable to install fake gemspec"
}

src_compile() {
	if use doc; then
		rake rerdoc || die "rake rerdoc failed"
	fi
}

src_test() {
	for ruby in $USE_RUBY; do
		[[ -n `type -p $ruby` ]] || continue
		$ruby $(type -p rake) test || die "testsuite failed"
	done
}

src_install() {
	pushd lib
	doruby -r * || die "doruby failed"
	popd

	if use doc; then
		dohtml -r html || die "dohtml failed"
	fi

	dodoc CHANGES README || die "dodoc failed"

	dofakegemspec
}
