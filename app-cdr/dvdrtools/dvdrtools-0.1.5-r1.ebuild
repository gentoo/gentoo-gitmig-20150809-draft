# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvdrtools/dvdrtools-0.1.5-r1.ebuild,v 1.2 2003/11/26 11:18:35 aliz Exp $

DESCRIPTION="This is the dvdrtools package a fork from cdrecord which permits dvdwriting"
HOMEPAGE="http://www.nongnu.org/dvdrtools/"
SRC_URI="http://savannah.nongnu.org/download/dvdrtools/dvdrtools.pkg/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="virtual/glibc"
PROVIDE="virtual/cdrtools"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall

	dodoc README NEWS INSTALL AUTHORS
}
