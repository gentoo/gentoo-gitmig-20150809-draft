# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.5.ebuild,v 1.12 2004/02/29 15:04:38 aliz Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Application startup notification and feedback library"
HOMEPAGE="http://www.freedesktop.org/software/startup-notification/"
SRC_URI="http://www.freedesktop.org/software/startup-notification/releases/${P}.tar.gz"

LICENSE="LGPL-2 BSD"
SLOT="0"
KEYWORDS="ia64 x86 ppc alpha sparc hppa amd64"
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
