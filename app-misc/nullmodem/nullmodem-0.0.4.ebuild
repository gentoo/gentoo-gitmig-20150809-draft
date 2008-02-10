# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nullmodem/nullmodem-0.0.4.ebuild,v 1.1 2008/02/10 18:48:58 bangert Exp $

inherit eutils

DESCRIPTION="A Utility to loopback Pseudo-Terminals"
HOMEPAGE="http://www.ant.uni-bremen.de/whomes/rinas/nullmodem/"
SRC_URI="http://www.ant.uni-bremen.de/whomes/rinas/nullmodem/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog README
}
