# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ups-monitor/ups-monitor-0.8.2.ebuild,v 1.1 2005/03/23 17:43:56 ka0ttic Exp $

DESCRIPTION="A UPS monitor for NUT (Network UPS Tools)"
HOMEPAGE="http://www.amautacorp.com/staff/Rudd-O/projects/pages/ups-front"
SRC_URI="http://www.amautacorp.com/staff/Rudd-O/projects/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-util/desktop-file-utils"
RDEPEND=">=dev-python/gnome-python-2
	>=gnome-base/libglade-2
	>=dev-python/pygtk-2.2"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog
}
