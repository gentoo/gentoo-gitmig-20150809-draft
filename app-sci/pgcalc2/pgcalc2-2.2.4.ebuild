# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pgcalc2/pgcalc2-2.2.4.ebuild,v 1.1 2004/06/22 23:51:05 absinthe Exp $

inherit kde
need-kde 3.2

MY_PV=2.2-4
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="PG Calculator is a powerful scientific calculator."
SRC_URI="mirror://sourceforge/${PN/2/}/${MY_P}.tar.gz"
HOMEPAGE="http://www.pgcalc.net"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

pkg_postinst() {
	posbs=(`ls ${S}/skins`)
	length=${#posbs}
	count=0
	einfo "To use another skin, start ${PN} with one of"
	einfo "the following options (case sensitive):"
	einfo ""
	while [ "${count}" -lt $((${length}+1)) ]
	do
		einfo "${posbs[${count}]}: '${PN} --skinname=${posbs[${count}]}'"
		count=$((${count}+1))
	done
	einfo ""
	einfo "The documentation is available at"
	einfo "/usr/share/doc/${PF}/html/index.htm"
	einfo ""
}
