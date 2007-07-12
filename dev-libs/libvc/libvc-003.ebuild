# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libvc/libvc-003.ebuild,v 1.12 2007/07/12 02:25:34 mr_bones_ Exp $

DESCRIPTION="vCard library (rolo)"
HOMEPAGE="http://rolo.sourceforge.net/"
SRC_URI="mirror://sourceforge/rolo/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha amd64"

src_install() {
	emake DESTDIR=${D} install
	rm ${D}/usr/share/man/man3/vc.3 # we will install later via doman
	dodoc AUTHORS COPYING.LIB INSTALL NEWS README THANKS ChangeLog doc/rfc2426.rfc
	doman doc/vc.3
}
