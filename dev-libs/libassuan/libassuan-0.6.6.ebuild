# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libassuan/libassuan-0.6.6.ebuild,v 1.2 2004/08/28 22:54:51 dholm Exp $

DESCRIPTION="Standalone IPC library used by gpg, gpgme and newpg"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libassuan"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
