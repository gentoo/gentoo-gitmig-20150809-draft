# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/partgui/partgui-0.2.2.ebuild,v 1.1 2003/09/12 10:57:18 phosphan Exp $

DESCRIPTION="PartGUI is a nice graphical partitioning tool"
HOMEPAGE="http://part-gui.sourceforge.net/"
SRC_URI="mirror://sourceforge/part-gui/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.1.0
	dev-libs/newt
	>=sys-apps/parted-1.6.5
	>=sys-apps/xfsprogs-2.3.9
	>=sys-apps/e2fsprogs-1.33"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	chmod +x ${D}/usr/sbin/partgui
}
