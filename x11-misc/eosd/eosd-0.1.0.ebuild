# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/eosd/eosd-0.1.0.ebuild,v 1.6 2004/09/19 19:56:15 vapier Exp $

DESCRIPTION="enlightened on-screen display draws anti-aliased text on your screen without creating a visible window"
HOMEPAGE="http://code-monkey.de/?eosd"
SRC_URI="http://www.code-monkey.de/data/eosd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1.1.1
	>=x11-libs/ecore-1.0.0_pre7"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
