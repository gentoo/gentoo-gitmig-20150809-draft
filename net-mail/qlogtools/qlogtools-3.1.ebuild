# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qlogtools/qlogtools-3.1.ebuild,v 1.5 2005/05/30 19:04:18 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Qmail Log processing tools"
HOMEPAGE="http://untroubled.org/qlogtools/"
SRC_URI="http://untroubled.org/qlogtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${P}" epatch ${FILESDIR}/qlogtools-3.1-errno.patch
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "${D}/usr/bin" > conf-bin
	echo "${D}/usr/share/man/" > conf-man
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/man/
	./installer || die "Installer failed"
	dodoc ANNOUNCEMENT FILES NEWS README TARGETS VERSION
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README for configuration information"
}
