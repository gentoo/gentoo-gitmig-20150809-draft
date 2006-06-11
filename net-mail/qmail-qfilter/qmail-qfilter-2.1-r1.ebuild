# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-qfilter/qmail-qfilter-2.1-r1.ebuild,v 1.1 2006/06/11 11:36:12 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="qmail-queue multi-filter front end"
HOMEPAGE="http://untroubled.org/qmail-qfilter/"
SRC_URI="${HOMEPAGE}archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/bglibs-1.0.19
	>=sys-apps/sed-4"
RDEPEND="virtual/libc
	virtual/qmail"

QMAIL_BINDIR="/var/qmail/bin/"
QFILTER_TMPDIR="/var/qmail/qfilter-tmp"

src_compile() {
	cd ${S}
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "${D}${QMAIL_BINDIR}" > conf-bin
	echo "${D}/usr/share/man/" > conf-man
	echo "${ROOT}/usr/include/bglibs" > conf-bgincs
	echo "${ROOT}/usr/lib/bglibs" > conf-bglibs

	sed -i "s:#define TMPDIR \"/tmp\":#define TMPDIR \"${QFILTER_TMPDIR}\":" qmail-qfilter.c

	make || die
}

src_install () {
#	dodir ${QMAIL_BINDIR} /usr/share/man/
	make install || die "Installer failed"

	keepdir ${QFILTER_TMPDIR}
	fowners qmaild:nofiles ${QFILTER_TMPDIR}
	fperms go-rwx ${QFILTER_TMPDIR}

	dodoc ANNOUNCEMENT NEWS README TODO
	docinto samples
	dodoc samples/*
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README* for configuration information"
}
