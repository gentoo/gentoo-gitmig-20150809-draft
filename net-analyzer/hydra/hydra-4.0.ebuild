# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-4.0.ebuild,v 1.2 2004/06/24 22:04:03 agriffis Exp $

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/openssl
	net-libs/libssh"

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
	dobin hydra pw-inspector || die "dobin failed"
	dodoc CHANGES HOW_TO_CONTRIBUTE README TODO
}
