# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-charconv/irssi-charconv-1.13.ebuild,v 1.4 2004/07/24 01:39:26 swegener Exp $

inherit gcc flag-o-matic

IRSSI_VERSION="0.8.6"

DESCRIPTION="An irssi plugin to do character set conversisions."
SRC_URI="http://irssi.org/files/irssi-${IRSSI_VERSION}.tar.bz2"
HOMEPAGE="http://norpan.org"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-libs/glib-1.2
	sys-libs/ncurses
	>=net-irc/irssi-${IRSSI_VERSION}"

S=${WORKDIR}

src_compile() {
	IRSSI="${WORKDIR}/irssi-${IRSSI_VERSION}"

	append-flags -fPIC

	touch ${IRSSI}/config.h && \
		$(gcc-getCC) ${FILESDIR}/charconv.c -Wall -g ${CFLAGS} -o ${T}/libcharconv.so -shared \
		-I$IRSSI/src -I$IRSSI/src/core -I$IRSSI/src/fe-common/core \
		`glib-config --cflags`
}

src_install() {
	exeinto /usr/lib/irssi/modules
	doexe ${T}/libcharconv.so

	dodoc ${FILESDIR}/README
}
