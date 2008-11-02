# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mcelog/mcelog-0.8_pre1.ebuild,v 1.9 2008/11/02 11:03:53 maekke Exp $

inherit eutils toolchain-funcs

MY_PV="${PV/_pre1/pre}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A tool to log and decode Machine Check Exceptions"
HOMEPAGE="ftp://ftp.x86-64.org/pub/linux/tools/mcelog/"
SRC_URI="ftp://ftp.x86-64.org/pub/linux/tools/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Not ready for prime-time
#KEYWORDS="~amd64 ~x86"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="virtual/cron"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-timestamp-mcelog.patch

	cd "${S}"
	sed -i \
		-e 's:-g:${CFLAGS}:g' \
		-e 's:\tgcc:\t$(CC):g' Makefile || die "sed makefile failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dosbin mcelog dbquery || die
	doman mcelog.8

	exeinto /etc/cron.daily
	newexe mcelog.cron mcelog || die

	insinto /etc/logrotate.d/
	newins mcelog.logrotate mcelog || die

	dodoc CHANGES README TODO *.pdf
}
