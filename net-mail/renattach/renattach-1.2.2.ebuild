# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/renattach/renattach-1.2.2.ebuild,v 1.1 2005/03/07 20:23:48 xmerlin Exp $

inherit eutils

DESCRIPTION="Filter that renames/deletes dangerous email attachments."
SRC_URI="http://www.pc-tools.net/files/unix/${P}.tar.gz"
HOMEPAGE="http://www.pc-tools.net/unix/renattach/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	econf || die "configure error"
	emake || die "build error"
}

src_install () {
	emake DESTDIR=${D} install || die "install error"
	mv ${D}/etc/renattach.conf.ex ${D}/etc/renattach.conf

	dodoc AUTHORS ChangeLog README COPYING INSTALL NEWS
}

