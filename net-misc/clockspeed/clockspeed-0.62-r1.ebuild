# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r1.ebuild,v 1.14 2003/02/28 16:55:00 liquidx Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A simple Network Time Protocol (NTP) client"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ppc"

DEPEND="sys-apps/groff"

src_compile() {
	epatch ${FILESDIR}/${PF}-gentoo.diff

	cp -a conf-cc conf-cc.orig
	sed "s:@CFLAGS@:${CFLAGS}:" < conf-cc.orig > conf-cc

	emake || die
}

src_install () {
	dodir /etc /usr/bin /usr/sbin /usr/share/man/man1
	insinto /etc
	doins leapsecs.dat

	into /usr
	dobin clockspeed clockadd clockview sntpclock taiclock taiclockd
	doman clockspeed.1 clockadd.1 clockview.1 sntpclock.1 taiclock.1 taiclockd.1

	exeinto /usr/sbin
	doexe ${FILESDIR}/ntpclockset

	dodoc BLURB CHANGES README THANKS TODO INSTALL
}

pkg_postinst() {
	echo
	einfo "Use ntpclockset to set your clock!"
	echo
}
