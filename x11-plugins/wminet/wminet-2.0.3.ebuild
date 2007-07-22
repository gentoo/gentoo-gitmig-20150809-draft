# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wminet/wminet-2.0.3.ebuild,v 1.13 2007/07/22 05:00:36 dberkholz Exp $

S="${WORKDIR}/${PN}.app"
IUSE=""
DESCRIPTION="dockapp that displays useful server statistics"
HOMEPAGE="http://www.neotokyo.org/illusion/dock_apps.html"
SRC_URI="http://www.neotokyo.org/illusion/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}/wminet
	sed -i -e "s:-O2:$CFLAGS:" Makefile
}

src_compile() {
	cd ${S}/wminet

	emake || die "parallel make failed"
}

src_install() {
	cd ${S}/wminet

	dobin wminet

	insinto /etc
	insopts -m 644
	doins wminetrc

	insinto /etc/skel
	insopts -m 600
	newins wminetrc .wminetrc
}
