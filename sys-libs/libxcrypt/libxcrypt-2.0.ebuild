# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libxcrypt/libxcrypt-2.0.ebuild,v 1.2 2004/04/26 14:40:52 agriffis Exp $

DESCRIPTION="Libxcrypt is a replacement for libcrypt, which comes with the GNU C \
Library. It supports DES crypt, MD5, and passwords with blowfish encryption."

SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.suse.de/us/private/products/suse_linux/i386/packages_personal/libxcrypt.html"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

#RDEPEND=""
S=${WORKDIR}/${P}

src_unpack() {

	unpack ${P}.tar.bz2
	cd ${S}

}

src_compile() {
	econf || die "econf failed"
	emake

}

src_install() {
	make install DESTDIR=${D}
}
