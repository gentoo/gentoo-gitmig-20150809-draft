# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-autoresponder/qmail-autoresponder-0.95.ebuild,v 1.5 2002/08/14 12:05:25 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rate-limited autoresponder for qmail."
SRC_URI="http://untroubled.org/qmail-autoresponder/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-autoresponder/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND=">=net-mail/qmail-1.03-r7"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe qmail-autoresponder
	doman qmail-autoresponder.1

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION
}

pkg_postinst() {

	echo 
	einfo "Using qmail-autoresponder ..."
	echo 
	einfo "Put \"|qmail-autoresponder MESSAGE_FILE DIRECTORY\" into your \".qmail\""
	einfo "file before other delivery instructions.  MESSAGE_FILE is a"
	einfo "pre-formatted response, including headers, and DIRECTORY is the"
	einfo "directory into which rate-limiting information will be stored.  Any"
	einfo "instance of "%S" in MESSAGE_FILE will be replaced with the original"
	einfo "subject."
	echo 
}
