# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/relay-ctrl/relay-ctrl-3.1.1.ebuild,v 1.1 2002/06/17 14:33:28 bangert Exp $

S=${WORKDIR}/${P}

DEPEND="virtual/glibc"

RDEPEND="net-mail/qmail"

LICENSE="GPL-2"
DESCRIPTION="SMTP Relaying Control for qmail & tcpserver."
SRC_URI="http://untroubled.org/relay-ctrl/${P}.tar.gz"

HOMEPAGE="http://untroubled.org/relay-ctrl/"

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
