# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r2.ebuild,v 1.3 2003/02/28 16:55:00 liquidx Exp $

inherit eutils

IUSE="static"

DESCRIPTION="A simple Network Time Protocol (NTP) client"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="sys-apps/groff"

src_compile() {
	epatch ${FILESDIR}/${PF}-gentoo.diff

	cp conf-cc{,.old}
	sed -e "s/@CFLAGS@/${CFLAGS}/" conf-cc.old > conf-cc

	use static && LDFLAGS="${LDFLAGS} -static"

	cp conf-ld{,.old}
	sed -e "s:@LDFLAGS@:${LDFLAGS}:" conf-ld.old > conf-ld

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
