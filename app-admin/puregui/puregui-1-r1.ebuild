# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puregui/puregui-1-r1.ebuild,v 1.13 2003/02/13 05:29:30 vapier Exp $

DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="mirror://sourceforge/pureftpd/${PN}.tar.gz"
HOMEPAGE="http://pureftpd.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf --cache-file=${FILESDIR}/config.cache
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog README
}
