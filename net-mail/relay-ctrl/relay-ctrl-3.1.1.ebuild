# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/relay-ctrl/relay-ctrl-3.1.1.ebuild,v 1.13 2004/07/15 02:26:06 agriffis Exp $

DESCRIPTION="SMTP Relaying Control for qmail & tcpserver."
SRC_URI="http://untroubled.org/relay-ctrl/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/relay-ctrl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="mail-mta/qmail"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe relay-ctrl-age relay-ctrl-allow relay-ctrl-check relay-ctrl-send relay-ctrl-udp relay-ctrl-chdir

	#NB: at some point the man page for relay-ctrl-chdir will be added!
	doman relay-ctrl-age.8 relay-ctrl-allow.8 relay-ctrl-check.8 relay-ctrl-send.8 relay-ctrl-udp.8
	dodoc README ANNOUNCEMENT NEWS

}
