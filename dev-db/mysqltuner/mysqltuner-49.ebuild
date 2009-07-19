# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltuner/mysqltuner-49.ebuild,v 1.1 2009/07/19 07:56:23 hollow Exp $

DESCRIPTION="MySQLTuner is a high-performance MySQL tuning script"
HOMEPAGE="http://www.mysqltuner.com"
SRC_URI="mirror://gentoo/${P}.pl"

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
	cp -f "${DISTDIR}"/${P}.pl "${S}"/${PN}
}

src_install() {
	dobin mysqltuner
}
