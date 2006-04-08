# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alltray/alltray-0.65.ebuild,v 1.4 2006/04/08 12:12:03 blubb Exp $

DESCRIPTION="Dock any application into the system tray/notification area"
HOMEPAGE="http://alltray.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
