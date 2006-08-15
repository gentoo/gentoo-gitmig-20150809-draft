# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libproccpuinfo/libproccpuinfo-0.0.5.ebuild,v 1.2 2006/08/15 17:26:05 tcort Exp $

DESCRIPTION="architecture independent C API for reading /proc/cpuinfo"
HOMEPAGE="https://savannah.nongnu.org/projects/proccpuinfo/"
SRC_URI="http://download.savannah.nongnu.org/releases/proccpuinfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog HACKING NEWS README THANKS TODO
}
