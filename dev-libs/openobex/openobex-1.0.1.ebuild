# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.0.1.ebuild,v 1.5 2004/03/14 12:24:18 mr_bones_ Exp $

IUSE=""

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=">=dev-libs/glib-1.2"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS NEWS ChangeLog
}
