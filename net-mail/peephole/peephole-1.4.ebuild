# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/peephole/peephole-1.4.ebuild,v 1.2 2004/11/25 05:32:18 weeve Exp $

DESCRIPTION="A daemon that polls your POP servers, checking if there are messages from particular persons."
HOMEPAGE="http://peephole.sourceforge.net/"
SRC_URI="mirror://sourceforge/peephole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7d-r1"

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS README
}

pkg_postinst() {
	einfo "Before you can use peephole you must copy"
	einfo "/etc/skel/.peephole.providers and /etc/skel/.peepholerc"
	einfo "to your home dir and edit them to suit your needs."
}
