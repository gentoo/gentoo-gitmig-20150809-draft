# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r2.ebuild,v 1.1 2003/01/10 01:36:26 vapier Exp $

DESCRIPTION="a simple ntp client"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="freeware"
SLOT="0"
IUSE="static"

DEPEND="virtual/glibc
	sys-apps/groff"
RDEPEND="virtual/glibc"

src_compile() {
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
	cp conf-cc{,.old}
	sed -e "s/@CFLAGS@/${CFLAGS}/" conf-cc.old > conf-cc
	use static && LDFLAGS="${LDFLAGS} -static"
	cp conf-ld{,.old}
	sed -e "s/@LDFLAGS@/${LDFLAGS}/" conf-ld.old > conf-ld
	emake || die
}

src_install() {
	dobin clockspeed clockadd clockview sntpclock taiclock taiclockd
	dosbin ${FILESDIR}/ntpclockset

	doman clockspeed.1 clockadd.1 clockview.1 sntpclock.1 taiclock.1 taiclockd.1
	dodoc BLURB CHANGES README THANKS TODO INSTALL

	insinto /etc
	doins leapsecs.dat
}

pkg_postinst() {
	echo
	einfo "Use ntpclockset to set your clock!"
	echo
}
