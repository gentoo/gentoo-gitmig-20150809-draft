# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mcelog/mcelog-0.8_pre1.ebuild,v 1.6 2008/02/22 19:35:30 robbat2 Exp $

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
	epatch "${FILESDIR}"/${PN}-0.8_pre1-timestamp-mcelog.patch
}

src_install() {
	dosbin mcelog dbquery
	doman mcelog.8

	exeinto /etc/cron.daily
	newexe mcelog.cron mcelog

	insinto /etc/logrotate.d/
	newins mcelog.logrotate mcelog

	dodoc CHANGES README TODO *.pdf
}
