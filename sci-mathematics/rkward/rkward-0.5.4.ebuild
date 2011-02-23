# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/rkward/rkward-0.5.4.ebuild,v 1.3 2011/02/23 14:45:26 tampakrap Exp $

EAPI=3

inherit kde4-base

DESCRIPTION="An IDE/GUI for the R-project"
HOMEPAGE="http://rkward.sourceforge.net/"
SRC_URI="mirror://sourceforge/rkward/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="dev-lang/R"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	# avoid file collisions
	rm -f "${ED}"/usr/$(get_libdir)/R/library/R.css
	rm -f "${ED}"/usr/share/apps/katepart/syntax/r.xml
}
