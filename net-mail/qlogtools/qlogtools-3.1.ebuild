# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qlogtools/qlogtools-3.1.ebuild,v 1.1 2003/08/01 05:02:36 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Qmail Log processing tools"
SRC_URI="http://untroubled.org/qlogtools/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qlogtools/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/glibc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	patch -p1 -d ${P} < ${FILESDIR}/qlogtools-3.1-errno.patch
}

src_compile() {
	cd ${S}
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
	echo "${D}/usr/bin" > conf-bin
	echo "${D}/usr/share/man/" > conf-man
	emake || die
}

src_install () {
	dodir /usr/bin /usr/share/man/
	./installer || die "Installer failed"
	dodoc ANNOUNCEMENT COPYING FILES NEWS README TARGETS VERSION
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README for configuration information"
}
