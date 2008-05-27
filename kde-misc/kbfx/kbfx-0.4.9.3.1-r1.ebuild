# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbfx/kbfx-0.4.9.3.1-r1.ebuild,v 1.9 2008/05/27 01:01:53 halcy0n Exp $

inherit kde eutils

need-kde 3.3

DESCRIPTION="KDE alternative K-Menu"
HOMEPAGE="http://www.kbfx.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	>=dev-util/cmake-2.4.2"

export DESTDIR=${D}

src_compile() {
	cd ${S}
	cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=${KDEDIR} \
		. || die "cmake (configure) failed"

	emake || die "emake failed"
}
