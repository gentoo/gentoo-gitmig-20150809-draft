# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mclient/mclient-2.8.ebuild,v 1.6 2006/05/14 11:59:41 mrness Exp $

DESCRIPTION="Simple command line Masqdialer client"
HOMEPAGE="None available"
SRC_URI="mirror://gentoo/cli-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe mclient
	dodoc CHANGES DISCLAIMER LICENSE
}
