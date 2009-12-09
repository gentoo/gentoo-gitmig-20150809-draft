# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62-r6.ebuild,v 1.2 2009/12/09 21:56:25 maekke Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="A simple Network Time Protocol (NTP) client"
HOMEPAGE="http://cr.yp.to/clockspeed.html"
SRC_URI="http://cr.yp.to/clockspeed/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~mips x86"
IUSE="static selinux"
RESTRICT="test"

DEPEND="sys-apps/groff"
RDEPEND="selinux? ( sec-policy/selinux-clockspeed )"

# this is the trailing part of the name for the latest leapseconds file.
LEAPSECONDS_DATE="20081114"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_configure() {
	echo "$(tc-getCC) ${CFLAGS} ${ASFLAGS}" > conf-cc
	use static && append-ldflags -static
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	dobin clockspeed clockadd clockview sntpclock taiclock taiclockd || die "dobin"
	dosbin "${FILESDIR}"/ntpclockset || die "dosbin"

	doman *.1
	dodoc BLURB CHANGES INSTALL README THANKS TODO

	insinto /var/lib/clockspeed
	newins "${FILESDIR}"/leapsecs.dat."$LEAPSECONDS_DATE" leapsecs.dat
}
