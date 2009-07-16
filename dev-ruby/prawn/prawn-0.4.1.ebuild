# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn/prawn-0.4.1.ebuild,v 1.2 2009/07/16 13:25:05 flameeyes Exp $

EAPI=2

GITHUB_USER=sandal

inherit ruby eutils

DESCRIPTION="Fast, Nimble PDF Generation For Ruby"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples test"

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${PV} -> ${P}.tgz"

USE_RUBY="ruby18"

RDEPEND="dev-ruby/ttfunk"
DEPEND="doc? ( dev-ruby/rake )
	test? (
		dev-ruby/rake
		dev-ruby/mocha
		dev-ruby/test-spec
		>=dev-ruby/pdf-reader-0.7.3
		${RDEPEND}
	)"

S="${WORKDIR}"

src_compile() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	if use doc; then
		rake rdoc || die "rake rdoc failed"
	fi
}

src_test() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	rake test || die "rake test failed"
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

	# This sucks but it has to go after test and before install.
	epatch "${FILESDIR}"/${P}-gentoo.patch

	pushd lib
	doruby -r * || die "install lib failed"
	popd

	insinto /usr/share/${PN}
	doins -r data || die

	dofakegemspec

	dodoc README HACKING || die "Installing docs failed."

	dohtml -r www/* || die

	if use doc; then
		docinto apidocs
		pushd doc
		dohtml -r * || die "Installing html documentation failed."
		popd
	fi

	if use examples; then
		docinto examples
		dodoc -r examples/* || die "Installing examples failes."
	fi
}
