# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.5.0.ebuild,v 1.23 2004/05/31 20:34:34 vapier Exp $

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/x11
	>=app-crypt/gnupg-1.0.4
	>=gnome-base/gnome-libs-1.4.1.2-r1"

src_install() {
	make DESTDIR=${D} \
	     localedir=${D}/usr/share/locale \
	     gnulocaledir=${D}/usr/share/locale install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
