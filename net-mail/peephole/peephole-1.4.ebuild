# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/peephole/peephole-1.4.ebuild,v 1.5 2007/06/12 12:58:47 genone Exp $

inherit eutils

DESCRIPTION="A daemon that polls your POP servers, checking if there are messages from particular persons."
HOMEPAGE="http://peephole.sourceforge.net/"
SRC_URI="mirror://sourceforge/peephole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7d-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS README
}

pkg_postinst() {
	elog "Before you can use peephole you must copy"
	elog "/etc/skel/.peephole.providers and /etc/skel/.peepholerc"
	elog "to your home dir and edit them to suit your needs."
}
