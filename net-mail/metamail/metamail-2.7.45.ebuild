# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/metamail/metamail-2.7.45.ebuild,v 1.6 2004/01/15 15:14:51 agriffis Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/mm2.7/src
DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="ftp://thumper.bellcore.com/pub/nsb/"
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/mm2.7.tar.Z
	http://ftp.debian.org/debian/pool/main/m/metamail/${PN}_2.7-45.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ia64"

DEPEND="sys-libs/ncurses
	app-arch/sharutils
	net-mail/mailbase"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/metamail_2.7-45.diff
	chmod +x ${S}/configure
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING CREDITS README
	rm man/mmencode.1
	doman man/*
	doman debian/mimencode.1 debian/mimeit.1
	insinto /etc
	doins ${FILESDIR}/mime.types
}

