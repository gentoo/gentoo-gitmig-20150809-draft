# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.5.ebuild,v 1.9 2003/07/01 17:50:37 gmsoft Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Application startup notification and feedback library"
HOMEPAGE="http://www.freedesktop.org/software/startup-notification/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"

LICENSE="LGPL-2 BSD"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa"
IUSE=""
DEPEND="virtual/x11"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README doc/startup-notification.txt
}
