# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtrlock/xtrlock-2.0-r1.ebuild,v 1.7 2005/03/29 17:50:04 luckyduck Exp $

inherit eutils flag-o-matic

MY_P=${P/-/_}-6
DESCRIPTION="A simplistic screen locking program for X"
SRC_URI="mirror://debian/dists/potato/main/source/x11/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.debian.org/debian/dists/stable/main/source/x11/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-overflow.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	xmkmf || die
	cp Makefile Makefile.orig
	make CFLAGS="${CFLAGS} -DSHADOW_PWD" xtrlock || die
}

src_install() {
	dobin xtrlock
	chmod u+s ${D}/usr/bin/xtrlock
	mv xtrlock.man xtrlock.1
	doman xtrlock.1
}
