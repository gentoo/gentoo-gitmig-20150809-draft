# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.3.ebuild,v 1.1 2002/11/03 14:38:48 foser Exp $

DESCRIPTION="Startup notification library"
HOMEPAGE="http://www.freedesktop.org/software/startup-notification/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11"
S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
