# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon/wmmon-1.0_beta2-r2.ebuild,v 1.10 2006/01/31 19:58:51 nelchael Exp $

inherit eutils

S="${WORKDIR}/${PN}.app"
IUSE=""
DESCRIPTION="Dockable system resources monitor applet for WindowMaker"
WMMON_VERSION=1_0b2
SRC_URI="http://rpig.dyndns.org/~anstinus/Linux/${PN}-${WMMON_VERSION}.tar.gz"
HOMEPAGE="http://www.bensinclair.com/dockapp/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc"

src_unpack() {
	unpack ${A} ; cd ${S}/${PN}
	epatch ${FILESDIR}/${P}-kernel26.patch
	sed -i -e "s|-O2|${CFLAGS}|" Makefile
}

src_compile() {
	emake -C ${PN} || die
}

src_install () {
	dobin wmmon/wmmon
	dodoc BUGS CHANGES HINTS README TODO
}
