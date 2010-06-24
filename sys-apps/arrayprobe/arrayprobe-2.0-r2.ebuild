# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/arrayprobe/arrayprobe-2.0-r2.ebuild,v 1.3 2010/06/24 07:03:22 angelos Exp $

inherit eutils
inherit autotools

DESCRIPTION="CLI utility that reports the status of a HP (Compaq) array controller (both IDA & CCISS supported)."
HOMEPAGE="http://www.strocamp.net/opensource/arrayprobe.php"
SRC_URI="http://www.strocamp.net/opensource/compaq/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="virtual/linux-sources"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-malloc-strlen.patch"
	epatch "${FILESDIR}/${PV}-ida_headers.patch"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die
}
