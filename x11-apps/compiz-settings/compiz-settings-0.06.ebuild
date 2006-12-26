# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/compiz-settings/compiz-settings-0.06.ebuild,v 1.1 2006/12/26 22:27:21 hanno Exp $

DESCRIPTION="Configuration tool for compiz window manager"
HOMEPAGE="http://forum.go-compiz.org/viewtopic.php?t=153"
SRC_URI="http://compiz.biz/compiz-settings/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-wm/compiz-0.3.4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN/-/}-trunk

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
}
