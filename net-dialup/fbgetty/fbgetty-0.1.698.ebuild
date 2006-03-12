# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698.ebuild,v 1.10 2006/03/12 10:37:23 mrness Exp $

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://projects.meuh.org/fbgetty/"
SRC_URI="http://projects.meuh.org/fbgetty/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

src_install() {
	einstall || die "make install failed"
}
