# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gtkskan/gtkskan-0.2.ebuild,v 1.7 2004/07/14 06:29:52 mr_bones_ Exp $


DESCRIPTION="GTK+-based ESSID scanner"
HOMEPAGE="http://wavelan-tools.sf.net"
SRC_URI="mirror://sourceforge/wavelan-tools/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE="gnome"

DEPEND="virtual/libc
	=sys-libs/db-1.85*
	=x11-libs/gtk+-1.2*
	gnome? (
		>=gnome-base/gnome-libs-1.4
		>=gnome-base/gnome-core-1.4 )"

src_compile() {
	local myconf
	use gnome && myconf="--with-gnome" || myconf="--without-gnome"

	CFLAGS="${CFLAGS} -I." ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"
	ln -s /usr/include/db1/db.h src/db_185.h
	emake || die
}

src_install () {
	dodir /usr/bin
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc CREDITS LICENSE README
}
