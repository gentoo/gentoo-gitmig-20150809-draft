# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/partgui/partgui-0.2.3-r2.ebuild,v 1.1 2004/02/18 14:46:58 phosphan Exp $

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
	>=sys-fs/xfsprogs-2.3.9
	sys-libs/slang
	>=sys-fs/e2fsprogs-1.33
	>=sys-apps/sed-4"

src_compile() {
	econf --disable-static || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	rm ${D}/usr/sbin/run_partgui
	mv ${D}/usr/sbin/piguicqt ${D}/usr/sbin/partgui
	dodoc ChangeLog README THANKS TODO AUTHORS
}
