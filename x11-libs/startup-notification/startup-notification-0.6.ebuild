# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.6.ebuild,v 1.12 2004/11/04 21:57:25 vapier Exp $

inherit gnome.org

DESCRIPTION="Application startup notification and feedback library"
HOMEPAGE="http://www.freedesktop.org/software/startup-notification/"
#SRC_URI="http://www.freedesktop.org/software/startup-notification/releases/${P}.tar.gz"

LICENSE="LGPL-2 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README doc/startup-notification.txt

}
