# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-charconv/irssi-charconv-1.13.ebuild,v 1.3 2004/06/24 23:05:55 agriffis Exp $

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
		net-irc/irssi"
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	IRSSI="${WORKDIR}/irssi-${IRSSI_VERSION}"

	touch ${IRSSI}/config.h && \
	gcc ${FILESDIR}/charconv.c -Wall -g -o ${T}/libcharconv.so -shared \
	-I$IRSSI/src -I$IRSSI/src/core -I$IRSSI/src/fe-common/core \
	`glib-config --cflags`
}

src_install() {
	insinto /usr/lib/irssi/modules
	doins ${T}/libcharconv.so

	dodoc ${FILESDIR}/README
}

