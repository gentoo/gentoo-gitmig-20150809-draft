# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-0.80.ebuild,v 1.1 2002/12/17 18:36:33 vapier Exp $

DESCRIPTION="http://libtomcrypt.iahu.ca/"
HOMEPAGE="http://libtomcrypt.iahu.ca/"
SRC_URI="http://iahu.ca:8080/download/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-text/tetex"

src_compile() {
	emake || die
}

src_install() {
	patch -p0 < ${FILESDIR}/makefile-path.patch
	make DESTDIR=${D} install || die
}
