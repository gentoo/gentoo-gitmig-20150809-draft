# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ginac/ginac-1.3.4.ebuild,v 1.1 2006/07/12 02:13:01 markusle Exp $

inherit eutils

DESCRIPTION="GiNaC : a free CAS (computer algebra system)"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${P}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="sci-libs/cln"

src_install() {
	make DESTDIR=${D} install || die
}
