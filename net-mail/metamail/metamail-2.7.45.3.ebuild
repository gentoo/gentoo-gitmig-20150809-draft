# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/metamail/metamail-2.7.45.3.ebuild,v 1.2 2004/05/11 22:55:13 kloeri Exp $

inherit eutils

IUSE=""

MY_PV=${PV%.*.*}-${PV#*.*.}
S=${WORKDIR}/mm${PV%.*.*}/src
DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="ftp://thumper.bellcore.com/pub/nsb/"
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/mm${PV%.*.*}.tar.Z
	http://ftp.debian.org/debian/pool/main/m/metamail/metamail_${MY_PV}.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha ~ia64 ~sparc ~s390 ~amd64 ~hppa"

DEPEND="sys-libs/ncurses
	app-arch/sharutils
	net-mail/mailbase"

src_unpack() {
	unpack ${A}
	export WANT_AUTOCONF=2.1
	cd ${S}
	epatch ${WORKDIR}/metamail_${MY_PV}.diff
	autoreconf
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

