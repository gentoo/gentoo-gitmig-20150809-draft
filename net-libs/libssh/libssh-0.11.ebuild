# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.11.ebuild,v 1.1 2005/03/05 07:46:10 ka0ttic Exp $

DESCRIPTION="access a working SSH implementation by means of a library"
HOMEPAGE="http://0xbadc0de.be/?part=libssh"
SRC_URI="http://www.0xbadc0de.be/libssh/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/openssl"

src_install() {
	make prefix="${D}/usr" install || die "make install failed"
	chmod a-x ${D}/usr/include/libssh/*
}
