# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.0.7.ebuild,v 1.1 2005/03/21 00:37:17 stkn Exp $

inherit eutils

IUSE="bri"

BRI_VERSION="0.2.0-RC7k"

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/libpri/libpri-${PV}.tar.gz
	 bri? http://www.junghanns.net/asterisk/downloads/bristuff-${BRI_VERSION}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	if use bri; then
		einfo "Patching libpri w/ BRI stuff (${BRI_VERSION})"
		epatch ${WORKDIR}/bristuff-${BRI_VERSION}/patches/libpri.patch
	fi

	# use system CFLAGS
	sed -i  -e "s:^CFLAGS=:CFLAGS+=:" \
		-e "/^CFLAGS[\t ]\++=/ d" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README TODO LICENSE
}
