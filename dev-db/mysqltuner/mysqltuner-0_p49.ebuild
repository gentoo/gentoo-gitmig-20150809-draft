# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltuner/mysqltuner-0_p49.ebuild,v 1.1 2010/01/31 07:45:30 robbat2 Exp $

DESCRIPTION="MySQLTuner is a high-performance MySQL tuning script"
HOMEPAGE="http://www.mysqltuner.com"
MY_PV="${PV/0_p}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://gentoo/${MY_P}.pl"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6
	virtual/perl-Getopt-Long
	>=virtual/mysql-3.23"

src_unpack() {
	mkdir -p "${S}"
	cp -f "${DISTDIR}"/${MY_P}.pl "${S}"/${PN}
}

src_install() {
	dobin mysqltuner
}
