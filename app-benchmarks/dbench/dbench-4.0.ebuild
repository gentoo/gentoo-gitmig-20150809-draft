# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-4.0.ebuild,v 1.1 2008/11/23 09:46:22 patrick Exp $

DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://ftp.samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="http://samba.org/ftp/tridge/dbench/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

inherit eutils autotools

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${P}"
	eautoheader
	eautoconf
	econf
	}

src_install() {
	dobin dbench tbench tbench_srv
	dodoc README INSTALL
	doman dbench.1
	insinto /usr/share/dbench
	doins client.txt
}

pkg_postinst() {
	elog "You can find the client.txt file in ${ROOT}usr/share/dbench."
}
