# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698.ebuild,v 1.1 2003/11/22 20:49:46 lanius Exp $

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://fbgetty.meuh.eu.org/"
SRC_URI="${HOMEPAGE}downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	einstall || die
}
