# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mmpython/mmpython-0.4.2.ebuild,v 1.3 2004/06/25 01:34:10 agriffis Exp $

inherit distutils

DESCRIPTION="Media metadata retrieval framework for Python."
HOMEPAGE="http://sourceforge.net/projects/mmpython/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="${DEPEND}
	>=media-libs/libdvdread-0.9.3
	media-video/lsdvd"
