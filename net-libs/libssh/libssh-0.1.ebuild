# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.1.ebuild,v 1.5 2004/08/16 10:29:04 eldad Exp $

DESCRIPTION="access a working SSH implementation by means of a library"
HOMEPAGE="http://0xbadc0de.be/projects/sshlib.html"
SRC_URI="http://www.0xbadc0de.be/projects/libssh/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/openssl"

src_install() {
	make prefix="${D}/usr" install || die "make install failed"
	newbin ssh ${PN}-ssh || die "newbin failed"
	dosym ${PN}-ssh /usr/bin/${PN}-sftp
	[ ! -e "${ROOT}/usr/bin/ssh" ] && dosym ${PN}-ssh /usr/bin/ssh
	[ ! -e "${ROOT}/usr/bin/sftp" ] && dosym ${PN}-ssh /usr/bin/sftp
	chmod a-x ${D}/usr/include/libssh/*
}
