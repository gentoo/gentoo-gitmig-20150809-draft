# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r3.ebuild,v 1.9 2004/11/02 00:30:23 robbat2 Exp $

inherit eutils

DESCRIPTION="A simple Network Time Protocol (NTP) client"
HOMEPAGE="http://cr.yp.to/clockspeed.html"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc ~amd64 ~mips"
IUSE="static selinux"

DEPEND="sys-apps/groff"
RDEPEND=" selinux? ( sec-policy/selinux-clockspeed )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch
	sed -i "s:@CFLAGS@:${CFLAGS}:" conf-cc
	use static && LDFLAGS="${LDFLAGS} -static"
	sed -i "s:@LDFLAGS@:${LDFLAGS}:" conf-ld
}

src_compile() {
	emake || die
}

src_install() {
	dobin clockspeed clockadd clockview sntpclock taiclock taiclockd
	dosbin ${FILESDIR}/ntpclockset

	doman clockspeed.1 clockadd.1 clockview.1 sntpclock.1 taiclock.1 taiclockd.1
	dodoc BLURB CHANGES INSTALL README THANKS TODO

	insinto /var/lib/clockspeed
	doins leapsecs.dat
}
