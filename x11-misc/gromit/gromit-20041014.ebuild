# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gromit/gromit-20041014.ebuild,v 1.2 2004/11/18 19:08:26 brix Exp $

DESCRIPTION="GRaphics Over MIscellaneous Things, a presentation helper"

HOMEPAGE="http://www.home.unix-ag.org/simon/gromit/"
SRC_URI="http://www.home.unix-ag.org/simon/gromit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

src_unpack() {
	unpack ${A}

	sed -i "s:-Wall:-Wall ${CFLAGS}:" ${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe gromit

	newdoc gromitrc gromitrc.example

	dodoc AUTHORS ChangeLog README
}
