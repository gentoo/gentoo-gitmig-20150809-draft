# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-network/gnome-network-1.0.2-r1.ebuild,v 1.2 2002/08/16 04:13:58 murphy Exp $


S=${WORKDIR}/${P}
DESCRIPTION="gnome-network"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

RDEPEND="=gnome-base/gnome-panel-1.4*
	=dev-util/guile-1.4*
	>=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.2
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"
	cp sync/sync.h sync/sync.h.old
	cat  sync/sync.h.old | sed -e s@db.h@db1/db.h@g > sync/sync.h	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--without-gnome-sync \
		--enable-static=no \
		--localstatedir=/var/lib || die "configure failure. please report to http://bugs.gentoo.org"
	emake || die "compile error"
	
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}


