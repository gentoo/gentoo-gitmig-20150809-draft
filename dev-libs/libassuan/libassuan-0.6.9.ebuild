# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libassuan/libassuan-0.6.9.ebuild,v 1.3 2005/01/03 22:00:37 gustavoz Exp $

DESCRIPTION="Standalone IPC library used by gpg, gpgme and newpg"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libassuan"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~s390 ~x86 ~sparc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
