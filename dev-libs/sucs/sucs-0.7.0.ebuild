# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/sucs/sucs-0.7.0.ebuild,v 1.7 2004/07/14 15:08:31 agriffis Exp $

DESCRIPTION="The Simple Utility Classes are C++ libraries of common C-based algorithms and libraries"
HOMEPAGE="http://sucs.sourceforge.net/"
SRC_URI="mirror://sourceforge/sucs/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.9
	>=dev-libs/expat-1.95.4"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO COPYING
}
