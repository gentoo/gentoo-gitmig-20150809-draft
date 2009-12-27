# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-reader/pdf-reader-0.7.5.ebuild,v 1.2 2009/12/27 17:21:19 graaff Exp $

EAPI=2

GITHUB_USER=yob

inherit ruby

DESCRIPTION="PDF parser conforming as much as possible to the PDF specification from Adobe"
HOMEPAGE="http://github.com/yob/pdf-reader/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RESTRICT=test

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${P}.tgz"

USE_RUBY="ruby18"

DEPEND="doc? ( dev-ruby/rake dev-ruby/rspec )
	test? ( dev-ruby/rake dev-ruby/rspec )"
RDEPEND=""

S="${WORKDIR}"

src_compile() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	if use doc; then
		rake doc || die "rake rdoc failed"
	fi
}

src_test() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	rake spec || die "rake test failed"
}

dofakegemspec() {
	cat - > "${T}"/${P}.gemspec <<EOF
Gem::Specification.new do |s|
  s.name = "${PN}"
  s.version = "${PV}"
  s.summary = "${DESCRIPTION}"
  s.homepage = "${HOMEPAGE}"
end
EOF

	# Note: this only works with 1.8 so if you need to make it work
	# with 1.9 you better wait for ruby-fakegem.eclass.
	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')/../gems/1.8/specifications
	doins "${T}"/${P}.gemspec || die "Unable to install fake gemspec"
}

src_install() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	pushd lib
	doruby -r * || die "install lib failed"
	popd

	dodoc CHANGELOG README.rdoc TODO || die "Installing docs failed."

	if use doc; then
		pushd doc
		dohtml -r * || die "Installing html documentation failed."
		popd
	fi

	# Don't install binaries, they don't seem be to be very useful for now

	dofakegemspec
}
