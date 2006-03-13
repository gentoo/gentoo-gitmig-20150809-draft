# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ups-monitor/ups-monitor-0.8.2.ebuild,v 1.3 2006/03/13 20:31:43 jokey Exp $

DESCRIPTION="A UPS monitor for NUT (Network UPS Tools)"
HOMEPAGE="http://rudd-o.com/wp-content/projects/files/ups-monitor"
SRC_URI="http://rudd-o.com/wp-content/projects/files/ups-monitor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-util/desktop-file-utils"
RDEPEND=">=dev-python/gnome-python-2
	>=gnome-base/libglade-2
	>=dev-python/pygtk-2.4"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog
}
