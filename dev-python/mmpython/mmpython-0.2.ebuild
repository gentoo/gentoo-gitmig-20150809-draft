# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mmpython/mmpython-0.2.ebuild,v 1.5 2003/11/17 03:39:53 max Exp $

inherit distutils

DESCRIPTION="Media metadata retrieval framework for Python."
HOMEPAGE="http://sourceforge.net/projects/mmpython/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="${DEPEND}
	>=media-libs/libdvdread-0.9.3"

S="${WORKDIR}/${PN}"
