# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-recode/irssi-recode-1.36.ebuild,v 1.5 2004/07/24 01:35:18 swegener Exp $

inherit gcc flag-o-matic

IRSSI="0.8.6"

DESCRIPTION="A third party character set converting module for the Irssi IRC client"
SRC_URI="http://irssi.org/files/irssi-${IRSSI}.tar.bz2"
HOMEPAGE="http://lefort.be.eu.org/irssi/"

DEPEND=">=net-irc/irssi-${IRSSI}
	>=dev-libs/glib-2.0"
#Irssi needs to be compiled with glib-2

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

S=${WORKDIR}

src_compile() {
	append-flags -fPIC

	touch ${WORKDIR}/irssi-${IRSSI}/config.h &&
	$(gcc-getCC) -g -shared ${CFLAGS} -DHAVE_CONFIG_H -I${WORKDIR}/irssi-${IRSSI} -I${WORKDIR}/irssi-${IRSSI}/src \
		-I${WORKDIR}/irssi-${IRSSI}/src/core -I${WORKDIR}/irssi-${IRSSI}/src/fe-common/core -I${WORKDIR}/irssi-${IRSSI}/src/irc/core \
		-I${WORKDIR}/irssi-${IRSSI}/src/irc/dcc `pkg-config --cflags glib-2.0` -o ${T}/librecode.so ${FILESDIR}/recode.c || die "compile failed"
}

src_install() {
	exeinto /usr/lib/irssi/modules
	doexe ${T}/librecode.so
}

pkg_postinst() {
	einfo ""
	einfo ""/load recode" in Irssi and type "/help recode" for help"
	einfo ""
}
