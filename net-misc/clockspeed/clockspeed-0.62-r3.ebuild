# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r3.ebuild,v 1.10 2005/05/14 18:24:19 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="A simple Network Time Protocol (NTP) client"
HOMEPAGE="http://cr.yp.to/clockspeed.html"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips x86"
IUSE="static selinux"

DEPEND="sys-apps/groff"
RDEPEND=" selinux? ( sec-policy/selinux-clockspeed )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	echo "$(tc-getCC) ${CFLAGS} ${ASFLAGS}" > conf-cc
	use static && append-ldflags -static
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	dobin clockspeed clockadd clockview sntpclock taiclock taiclockd || die "dobin"
	dosbin "${FILESDIR}"/ntpclockset || die "dosbin"

	doman clockspeed.1 clockadd.1 clockview.1 sntpclock.1 taiclock.1 taiclockd.1
	dodoc BLURB CHANGES INSTALL README THANKS TODO

	insinto /var/lib/clockspeed
	doins leapsecs.dat
}
