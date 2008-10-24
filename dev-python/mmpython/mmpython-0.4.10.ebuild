# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mmpython/mmpython-0.4.10.ebuild,v 1.3 2008/10/24 17:55:06 flameeyes Exp $

inherit eutils distutils

DESCRIPTION="Media metadata retrieval framework for Python."
HOMEPAGE="http://sourceforge.net/projects/mmpython/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="dvd"

DEPEND="dvd? ( >=media-libs/libdvdread-0.9.3 )"
RDEPEND="${DEPEND} dvd? ( >=media-video/lsdvd-0.10 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-missing_stdint_headers.patch
}
