# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grpn/grpn-1.1.2.ebuild,v 1.10 2006/10/22 01:23:32 omp Exp $

DESCRIPTION="GRPN is a Reverse Polish Notation calculator for X"
HOMEPAGE="http://lashwhip.com/grpn.html"
SRC_URI="http://lashwhip.com/grpn/${P}.tar.gz"

DEPEND="=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc alpha ~hppa"
IUSE=""

src_install () {
	dobin grpn
	doman grpn.1
	dodoc CHANGES README
}
