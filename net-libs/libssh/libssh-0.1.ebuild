# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.1.ebuild,v 1.6 2004/09/25 04:22:04 vapier Exp $

DESCRIPTION="access a working SSH implementation by means of a library"
HOMEPAGE="http://0xbadc0de.be/projects/sshlib.html"
SRC_URI="http://www.0xbadc0de.be/projects/libssh/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86"
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
