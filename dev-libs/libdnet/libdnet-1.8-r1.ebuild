# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.8-r1.ebuild,v 1.1 2004/08/05 20:04:53 rphillips Exp $

inherit eutils

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~ia64 ~amd64"
IUSE="python"

src_compile () {
	econf `use_with python python`
	emake
}

src_install () {
	einstall || die
	dodoc ChangeLog VERSION README
}
