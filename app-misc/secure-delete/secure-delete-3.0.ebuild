# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/secure-delete/secure-delete-3.0.ebuild,v 1.15 2005/04/01 03:30:47 agriffis Exp $

MY_P=${PN//-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure file/disk/swap/memory erasure utilities"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~hppa ~amd64 ia64 ~ppc64"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	!app-misc/srm"

src_unpack() {
	unpack ${A} ; cd ${S}
	chmod u+w .

	sed -i \
		-e 's|mktemp|mkstemp|g' \
		sfill.c
}

src_compile() {
	make OPT="${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64" || die
}

src_install() {
	make \
		INSTALL_DIR=${D}/usr/bin \
		MAN_DIR=${D}/usr/share/man \
		DOC_DIR=${D}/usr/share/doc/${PF} \
		install || die "compile problem"

	dodoc secure_delete.doc usenix6-gutmann.doc
}

pkg_postinst() {
	einfo "sfill and srm are useless on journaling filesystems,"
	einfo "such as reiserfs or XFS."
	einfo "See documentation for more information."
}
