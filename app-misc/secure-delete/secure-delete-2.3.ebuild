# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/secure-delete/secure-delete-2.3.ebuild,v 1.4 2004/03/14 10:59:03 mr_bones_ Exp $

DESCRIPTION="Secure file/disk/swap/memory erasure utlities"
HOMEPAGE="http://www.thehackerschoice.com/"
SRC_URI="http://www.thehackerschoice.com/releases/${PN//-/_}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S="${WORKDIR}/${PN//-/_}-${PV}"

src_unpack() {
	unpack ${A}

	cd ${S}

	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e "s|^OPT=-O2|OPT=${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64|" \
		-e "s|^INSTALL_DIR=.*|INSTALL_DIR=${D}/usr/bin|" \
		-e "s|^MAN_DIR=.*|MAN_DIR=${D}/usr/share/man|"

	mv sfill.c sfill.c.orig
	sed <sfill.c.orig >sfill.c \
		-e 's|mktemp|mkstemp|g'
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	make install || die
	dodoc secure_delete.doc usenix6-gutmann.doc
}

pkg_postinst() {
	einfo "sfill and srm are useless on journalling filesystems, such as reiserfs or XFS."
	einfo "See documentation for more information."
}
