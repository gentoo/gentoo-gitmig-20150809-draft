# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-0.4.4.ebuild,v 1.8 2004/08/24 03:00:42 swegener Exp $

MY_P="${PN}_${PV}-4.1"

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://joostje.op.het.net/fakeroot/index.html"
SRC_URI="mirror://debian/dists/potato/main/source/utils/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~hppa amd64"
IUSE=""

RDEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die "install problem"
}
