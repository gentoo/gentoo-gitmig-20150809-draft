# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.0.8.ebuild,v 1.13 2003/04/24 11:18:25 vapier Exp $

DESCRIPTION="bug-buddy"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
IUSE="nls"

RDEPEND="virtual/glibc
        >=gnome-base/gnome-vfs-1.0.2-r1
        >=gnome-base/libglade-0.17-r1
        >=media-libs/gdk-pixbuf-0.11.0-r1
	dev-libs/libxml"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    `use_enable nls` \
		    || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	dodoc AUTHORS COPYING* NEWS README* TODO
}
