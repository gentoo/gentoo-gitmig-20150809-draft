# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698.ebuild,v 1.4 2004/06/24 22:25:50 agriffis Exp $

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://fbgetty.meuh.eu.org/"
SRC_URI="${HOMEPAGE}downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DEPEND="virtual/glibc"

src_install() {
	einstall || die
}
