# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xnetload/xnetload-1.11.3-r1.ebuild,v 1.1 2006/01/19 02:22:15 vanquirius Exp $

DESCRIPTION="This little tool displays a count and a graph of the traffic over a specified network connection."
HOMEPAGE="http://www.xs4all.nl/~rsmith/software/"
SRC_URI="http://www.xs4all.nl/~rsmith/software/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="|| (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libXmu-1.0.0
	>=x11-libs/libXt-1.0.0
	>=x11-libs/libXaw-1.0.1	)
	virtual/x11 )"

IUSE=""

src_install() {
	dobin xnetload
	doman xnetload.1
	dodoc README
}
