# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libassuan/libassuan-0.6.5.ebuild,v 1.6 2005/01/02 06:04:52 dragonheart Exp $

DESCRIPTION="Standalone IPC library used by gpg, gpgme and newpg"

HOMEPAGE="http://ftp.gnupg.org/gcrypt/alpha/libassuan/"
SRC_URI="http://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_install()
{
	make install DESTDIR=${D} || die
}
