# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/rkward/rkward-0.5.0b.ebuild,v 1.1 2008/10/21 14:35:35 bicatali Exp $

EAPI="2"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="An IDE/GUI for the R-project"
HOMEPAGE="http://rkward.sourceforge.net/"
SRC_URI="mirror://sourceforge/rkward/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-lang/R-2.7.0
		dev-lang/php"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install

	# avoid file collisions
	rm -f "${D}"/usr/$(get_libdir)/R/library/R.css
	rm -f "${D}"/usr/share/apps/katepart/syntax/r.xml
}
