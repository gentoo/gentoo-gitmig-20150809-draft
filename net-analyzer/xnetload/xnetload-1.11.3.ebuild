# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xnetload/xnetload-1.11.3.ebuild,v 1.8 2004/08/28 01:41:58 tgall Exp $

DESCRIPTION="This little tool displays a count and a graph of the traffic over a specified network connection."
HOMEPAGE="http://www.xs4all.nl/~rsmith/software/"
SRC_URI="http://www.xs4all.nl/~rsmith/software/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ppc64"

DEPEND="virtual/x11"

IUSE=""

src_compile() {
	make || die
}

src_install() {
	dobin xnetload
	doman xnetload.1
	dodoc README COPYING
}
