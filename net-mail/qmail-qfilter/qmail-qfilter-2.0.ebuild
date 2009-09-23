# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-qfilter/qmail-qfilter-2.0.ebuild,v 1.6 2009/09/23 19:10:29 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="qmail-queue multi-filter front end"
SRC_URI="http://untroubled.org/qmail-qfilter/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-qfilter/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/bglibs-1.0.19"
RDEPEND="${DEPEND} virtual/qmail"

QMAIL_BINDIR="/var/qmail/bin/"

src_compile() {
	cd ${S}
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "${D}${QMAIL_BINDIR}" > conf-bin
	echo "${D}/usr/share/man/" > conf-man
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	make || die
}

src_install () {
	dodir ${QMAIL_BINDIR} /usr/share/man/
	./installer || die "Installer failed"
	dodoc ANNOUNCEMENT NEWS README TODO VERSION
	docinto samples
	dodoc samples/*
}

pkg_postinst() {
	elog "Please see /usr/share/doc/${PF}/README for configuration information"
}
