# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbatteries/wmbatteries-0.1.3.ebuild,v 1.3 2006/01/24 22:15:05 nelchael Exp $

inherit eutils

DESCRIPTION="Dock app for monitoring the current battery status and CPU temperature"
HOMEPAGE="http://sourceforge.net/projects/wmbatteries"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS THANKS README example/wmbatteriesrc
}
