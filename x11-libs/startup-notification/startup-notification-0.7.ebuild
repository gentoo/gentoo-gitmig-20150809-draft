# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.7.ebuild,v 1.1 2004/08/04 01:05:48 tseng Exp $

inherit gnome.org

DESCRIPTION="Application startup notification and feedback library"
HOMEPAGE="http://www.freedesktop.org/software/startup-notification/"
#SRC_URI="http://www.freedesktop.org/software/startup-notification/releases/${P}.tar.gz"
LICENSE="LGPL-2 BSD"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ppc64"
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
