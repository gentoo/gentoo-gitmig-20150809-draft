# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lavaps/lavaps-2.4.ebuild,v 1.2 2003/12/26 01:02:12 pyrania Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lava Lamp graphical representation of running processes."
SRC_URI="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/${P}.tar.gz"
HOMEPAGE="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-lang/tk-8.3.3
	virtual/x11"

src_install() {

	dobin lavaps
	doman lavaps.1
	dodoc COPYING README
}
