# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/eosd/eosd-0.1.0.ebuild,v 1.1 2003/10/14 03:09:22 vapier Exp $

DESCRIPTION="enlightened on-screen display draws anti-aliased text on your screen without creating a visible window"
HOMEPAGE="http://code-monkey.de/index.php?eosd"
SRC_URI="http://www.code-monkey.de/data/eosd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/imlib2-1.1.0
	>=x11-libs/ecore-1.0.0.20031013_pre4"

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
