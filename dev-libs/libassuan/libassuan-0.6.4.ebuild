# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libassuan/libassuan-0.6.4.ebuild,v 1.2 2004/06/24 23:13:55 agriffis Exp $

DESCRIPTION="Standalone IPC library used by gpg, gpgme and newpg"

HOMEPAGE="http://ftp.gnupg.org/gcrypt/alpha/libassuan/"
SRC_URI="http://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_install()
{
	make install DESTDIR=${D} || die
}
