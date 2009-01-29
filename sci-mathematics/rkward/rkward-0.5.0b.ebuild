# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/rkward/rkward-0.5.0b.ebuild,v 1.3 2009/01/29 13:37:09 scarabeus Exp $

EAPI="2"

KDE_MINIMAL="4.1"
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

src_prepare(){
	kde4-base_src_prepare
	# fixing Rdevices.h missing header
	sed -i \
		-e '/#include "Rdevices.h"/d' \
		"${S}"/rkward/rbackend/rembedinternal.cpp || die
}

src_install() {
	kde4-base_src_install

	# avoid file collisions
	rm -f "${D}"/usr/$(get_libdir)/R/library/R.css
	rm -f "${D}"/usr/share/apps/katepart/syntax/r.xml
}
