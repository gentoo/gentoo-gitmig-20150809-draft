# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvdrtools/dvdrtools-0.1.4.ebuild,v 1.3 2003/06/29 16:01:56 aliz Exp $

DESCRIPTION="This is the dvdrtools package a fork from cdrecord which permits dvdwriting"
HOMEPAGE="http://www.nongnu.org/dvdrtools/"
SRC_URI="http://savannah.nongnu.org/download/dvdrtools/dvdrtools.pkg/0.1.4/dvdrtools-0.1.4.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
}
