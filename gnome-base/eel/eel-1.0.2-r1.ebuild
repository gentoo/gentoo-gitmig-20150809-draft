# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-1.0.2-r1.ebuild,v 1.1 2002/03/10 08:40:00 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="EEL libraries for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/freetype-2.0.1
         >=gnome-base/gnome-vfs-1.0.2-r1
         >=media-libs/gdk-pixbuf-0.11.0-r1
		 >=gnome-base/librsvg-1.0.1-r1"

DEPEND="${RDEPEND}
        nls? ( >=dev-util/intltool-0.11 )"

src_compile() { 

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	./configure --host=${CHOST}					\
		    --prefix=/usr						\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib			\
			${myconf} || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {                           

	make prefix=${D}/usr sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO

}
