# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/secure-delete/secure-delete-3.0.ebuild,v 1.2 2003/10/27 15:42:41 aliz Exp $

DESCRIPTION="Secure file/disk/swap/memory erasure utlities"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${PN//-/_}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=sys-apps/sed-4"

S="${WORKDIR}/${PN//-/_}-${PV}"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i \
		-e "s|^OPT=-O2|OPT=${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64|" \
		-e "s|^INSTALL_DIR=.*|INSTALL_DIR=${D}/usr/bin|" \
		-e "s|^MAN_DIR=.*|MAN_DIR=${D}/usr/share/man|" \
		-e "s|^DOC_DIR=.*|DOC_DIR=${D}/usr/share/doc/${PF}|" \
		Makefile

	sed -i \
		-e 's|mktemp|mkstemp|g' \
		sfill.c
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	make install || die
	dodoc secure_delete.doc usenix6-gutmann.doc
}

pkg_postinst() {
	einfo "sfill and srm are useless on journalling filesystems, such as reiserfs or XFS."
	einfo "See documentation for more information."
}
