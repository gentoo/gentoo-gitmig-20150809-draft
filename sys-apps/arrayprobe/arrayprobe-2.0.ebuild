# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/arrayprobe/arrayprobe-2.0.ebuild,v 1.1 2006/09/05 13:33:08 chainsaw Exp $

DESCRIPTION="CLI utility that reports the status of a HP (Compaq) array controller (both IDA & CCISS supported)."
HOMEPAGE="http://www.strocamp.net/opensource/arrayprobe.php"
SRC_URI="http://www.strocamp.net/opensource/compaq/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/linux-sources"

src_install() {
	make DESTDIR="${D}" install || die
}
