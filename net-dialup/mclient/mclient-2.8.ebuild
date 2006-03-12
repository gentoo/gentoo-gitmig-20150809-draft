# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mclient/mclient-2.8.ebuild,v 1.5 2006/03/12 17:14:37 mrness Exp $

DESCRIPTION="Simple command line Masqdialer client"
HOMEPAGE="http://cpwright.com/mserver/"
SRC_URI="http://cpwright.com/cli-mclient/cli-${P}.tar.gz"

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
