# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.4.ebuild,v 1.5 2004/07/28 21:44:18 vapier Exp $

inherit kde
need-qt 3.1

DESCRIPTION="nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-apps/parted-1.6.6
	>=sys-fs/e2fsprogs-1.33
	>=sys-fs/xfsprogs-2.3.9
	>=sys-fs/jfsutils-1.1.2
	>=sys-fs/ntfsprogs-1.7.1"

myconf="--disable-reiserfs"

src_install() {
	einstall || die
	dodoc doc/README doc/README.Debian doc/TODO.txt doc/BUGS doc/DEVELOPER-FAQ
}
