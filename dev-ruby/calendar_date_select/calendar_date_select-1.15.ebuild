# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/calendar_date_select/calendar_date_select-1.15.ebuild,v 1.1 2009/07/20 13:27:19 flameeyes Exp $

EAPI=2

GITHUB_USER=timcharper

inherit ruby eutils

DESCRIPTION="A popular and flexible JavaScript DatePicker for RubyOnRails"
HOMEPAGE="http://code.google.com/p/calendardateselect/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${PV} -> ${P}.tgz"

USE_RUBY="ruby18"

RDEPEND=""
DEPEND="doc? ( dev-ruby/rake )
	test? (
		dev-ruby/rake
		dev-ruby/rspec
		${RDEPEND}
	)"

S="${WORKDIR}"

src_compile() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	if use doc; then
		rake redocs || die "rake rdoc failed"
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

	insinto /usr/share/${PN}
	doins -r public || die

	dofakegemspec

	dodoc Readme.txt History.txt || die "Installing docs failed."

	if use doc; then
		docinto apidocs
		pushd doc
		dohtml -r * || die "Installing html documentation failed."
		popd
	fi
}
