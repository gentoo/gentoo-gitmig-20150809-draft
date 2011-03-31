# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/sync2cd/sync2cd-1.3.ebuild,v 1.5 2011/03/31 15:28:18 ssuominen Exp $

inherit distutils

DESCRIPTION="An incremental archiving tool to CD/DVD."
HOMEPAGE="http://www.calins.ch/software/sync2cd.html"
SRC_URI="http://www.calins.ch/download/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="cdr dvdr"

RDEPEND="virtual/eject
	cdr? ( virtual/cdrtools )
	dvdr? ( app-cdr/dvd+rw-tools )"
DEPEND=""

src_test() {
	cd "${S}"/tests
	./run.py || die "Unit tests failed"
}
