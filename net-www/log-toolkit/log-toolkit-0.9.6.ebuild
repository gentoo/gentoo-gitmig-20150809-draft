# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/log-toolkit/log-toolkit-0.9.6.ebuild,v 1.1 2004/05/21 13:03:44 zul Exp $

DESCRIPTION="set of tools to manipulate and maintain webserver logfiles"
HOMEPAGE="http://sourceforge.net/projects/log-toolkit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virutal/glibc
		net-www/apache"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
