# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.0-r1.ebuild,v 1.3 2009/05/10 20:48:16 ssuominen Exp $

EAPI=2
inherit ruby

IUSE="svg"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

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

		insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["vendorlibdir"]' | sed -e 's:vendor_ruby:gems:')/specifications
		doins "${T}"/${P}.gemspec || die "Unable to install fake gemspec"
}

src_install() {
	ruby_src_install

	dofakegemspec
}
