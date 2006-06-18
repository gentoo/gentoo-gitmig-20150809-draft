# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libproccpuinfo/libproccpuinfo-0.0.3.ebuild,v 1.1 2006/06/18 23:42:44 tcort Exp $

DESCRIPTION="architecture independent C API for reading /proc/cpuinfo"
HOMEPAGE="http://mediumbagel.org/proj/libproccpuinfo"
SRC_URI="http://mediumbagel.org/proj/libproccpuinfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
