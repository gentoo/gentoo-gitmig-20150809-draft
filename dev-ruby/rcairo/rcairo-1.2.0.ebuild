# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.2.0.ebuild,v 1.2 2006/12/31 05:01:31 pclouds Exp $

inherit ruby

IUSE="examples"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"

DEPEND=">=x11-libs/cairo-1.2.0"
PATCHES="${FILESDIR}/${P}-no-svg.patch"

src_install() {
	ruby_src_install --prefix="${D}"
	if `use examples`; then
		insinto /usr/share/doc/${PF}/samples
		doins samples/*
	fi
}
