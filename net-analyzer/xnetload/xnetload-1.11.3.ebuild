# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xnetload/xnetload-1.11.3.ebuild,v 1.4 2003/07/13 11:30:14 aliz Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="This little tool displays a count and a graph of the traffic over a specified network connection."
HOMEPAGE="http://www.xs4all.nl/~rsmith/software/"
SRC_URI="http://www.xs4all.nl/~rsmith/software/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11"

src_compile() {
	make || die
}

src_install() {
	dobin xnetload
	doman xnetload.1
	dodoc README COPYING
}
