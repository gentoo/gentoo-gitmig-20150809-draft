# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/sucs/sucs-0.7.0.ebuild,v 1.3 2003/07/12 09:22:23 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Simple Utility Classes are C++ libraries of common C-based algorithms and libraries."
SRC_URI="mirror://sourceforge/sucs/${P}.tar.bz2"
HOMEPAGE="http://sucs.sf.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND=">=dev-libs/libpcre-3.9
	>=dev-libs/expat-1.95.4"
IUSE=""

src_install()
{
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO COPYING
}
