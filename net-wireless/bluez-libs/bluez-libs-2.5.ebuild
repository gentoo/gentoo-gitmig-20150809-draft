# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-2.5.ebuild,v 1.2 2004/04/24 18:42:08 kugelfang Exp $

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""
DEPEND=""

src_compile() {
	use amd64 && sed -i -e 's/CFLAGS\ =\ @CFLAGS@/CFLAGS\ =\ @CFLAGS@\ -fPIC/' src/Makefile.in
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
