# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libvc/libvc-003.ebuild,v 1.3 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="vCard library"
HOMEPAGE="http://rolo.sourceforge.net/"
SRC_URI="mirror://sourceforge/rolo/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_install() {
	emake DESTDIR=${D} install
	rm ${D}/usr/share/man/man3/vc.3 # we will install later via doman
	dodoc AUTHORS COPYING.LIB INSTALL NEWS README THANKS ChangeLog doc/rfc2426.rfc
	doman doc/vc.3
}

