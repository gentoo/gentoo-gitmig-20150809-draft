# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ups-monitor/ups-monitor-0.8.3.ebuild,v 1.1 2005/12/11 21:05:48 vanquirius Exp $

DESCRIPTION="A UPS monitor for NUT (Network UPS Tools)"
HOMEPAGE="http://www.usm.edu.ec/~amadorm/software/"
SRC_URI="http://www.usm.edu.ec/~amadorm/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-util/desktop-file-utils"
RDEPEND=">=dev-python/gnome-python-2
	>=gnome-base/libglade-2
	>=dev-python/pygtk-2.4
	>=dev-python/pyorbit-2.0.1"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog
}
