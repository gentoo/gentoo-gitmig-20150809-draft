# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.0-r1.ebuild,v 1.5 2009/06/20 11:46:06 flameeyes Exp $

EAPI=2
inherit ruby

IUSE="svg"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"

USE_RUBY="ruby18"

RDEPEND=">=x11-libs/cairo-1.2.0[svg?]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
	ruby_src_install

	dofakegemspec
}
