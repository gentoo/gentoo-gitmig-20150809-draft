# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r1.ebuild,v 1.9 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a simple ntp client"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/"
KEYWORDS="x86 sparc sparc64"
LICENSE="freeware"
SLOT="0"

DEPEND="virtual/glibc
	sys-apps/groff"
RDEPEND="virtual/glibc"


src_compile() {
    cd ${S}
    patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
    cp -a conf-cc conf-cc.orig
    sed "s/@CFLAGS@/${CFLAGS}/" < conf-cc.orig > conf-cc
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
