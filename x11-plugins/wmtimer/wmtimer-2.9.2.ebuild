# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtimer/wmtimer-2.9.2.ebuild,v 1.1 2005/03/14 15:20:03 s4t4n Exp $

IUSE=""

MY_PV="2.92"
MY_P="${PN}-${MY_PV}"

S=${WORKDIR}/${MY_P}/${PN}

DESCRIPTION="Dockable clock which can run in alarm, countdown timer or chronograph mode"
SRC_URI="http://www.darkops.net/wmtimer/${MY_P}.tar.gz"
HOMEPAGE="http://www.darkops.net/wmtimer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc ~sparc"

RDEPEND="virtual/libc
	virtual/x11
	>=x11-libs/gtk+-2.6.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15.0
	>=sys-apps/sed-4.0.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2 -Wall:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin wmtimer
	cd ..
	dodoc README CREDITS Changelog
}
