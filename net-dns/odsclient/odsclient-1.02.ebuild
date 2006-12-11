# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/odsclient/odsclient-1.02.ebuild,v 1.5 2006/12/11 07:57:22 beu Exp $

inherit eutils

DESCRIPTION="Client for the Open Domain Server's dynamic dns"
HOMEPAGE="http://www.ods.org/"
SRC_URI="http://www.ods.org/${P}.tar.gz
	mirror://gentoo/${PN}.patch"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	sed -i "s:CFLAGS=-O2::" Makefile
	epatch ${DISTDIR}/${PN}.patch
	emake || die
}

src_install() {
	dosbin odsclient
}
