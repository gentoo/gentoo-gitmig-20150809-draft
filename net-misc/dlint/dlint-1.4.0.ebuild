# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dlint/dlint-1.4.0.ebuild,v 1.1 2002/01/26 08:01:46 blocke Exp $

P="dlint1.4.0"
S=${WORKDIR}/${P}
DESCRIPTION="Dlint analyzes any DNS zone you specify, and reports any problems it finds by displaying errors and warnings"
SRC_URI="http://www.domtools.com/pub/${P}.tar.gz"
HOMEPAGE="http://www.domtools.com/dns/dlint.shtml"

DEPEND="net-misc/bind-tools sys-devel/perl sys-apps/bash"
RDEPEND="${DEPEND}"

src_compile() {

	mv dlint dlint.orig
	sed 's/rrfilt=\"\/usr\/local\/bin\/digparse\"/rrfilt=\"\/usr\/bin\/digparse\"/' dlint.orig > dlint

}

src_install () {

	dobin digparse
	dobin dlint

	doman dlint.1

	dodoc BUGS COPYING INSTALL README CHANGES COPYRIGHT TESTCASES
}

