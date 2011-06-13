# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ups-monitor/ups-monitor-0.8.3-r1.ebuild,v 1.3 2011/06/13 15:02:40 pacho Exp $

DESCRIPTION="A UPS monitor for NUT (Network UPS Tools)"
HOMEPAGE="http://rudd-o.com/wp-content/projects/files/ups-monitor"
SRC_URI="http://rudd-o.com/wp-content/projects/files/ups-monitor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-util/desktop-file-utils"
RDEPEND=">=gnome-base/libglade-2
	>=dev-python/pygtk-2.4
	>=dev-python/pyorbit-2.0.1
	dev-python/gnome-python-base
	dev-python/pygobject
	dev-python/libgnome-python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e \
	's/Categories=X-Red-Hat-Base;Application;System;/Categories=System;/g' \
		-e 's:[.]png$::' \
	ups-monitor.desktop || die "Sed Broke!"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog
}
