# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-3.0.ebuild,v 1.1 2004/02/14 04:47:39 vapier Exp $

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/hydra-3.0.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd ${S}
	# using openssl instead of libdes
	sed -i 's:#include <des.h>:#include <openssl/des.h>:' hydra-smbnt.c
	sed -i "s:-O2:${CFLAGS} -DLIBDES:" Makefile.am
}

src_compile() {
	einfo "Disregard the 'smbnt disabled' message below, it's enabled."
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dobin hydra || die "dobin failed"
	dodoc README TODO CHANGES
}
