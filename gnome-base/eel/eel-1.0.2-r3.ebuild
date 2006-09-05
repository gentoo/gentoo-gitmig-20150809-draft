# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-1.0.2-r3.ebuild,v 1.18 2006/09/05 01:47:08 kumba Exp $

DESCRIPTION="EEL libraries for GNOME"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="arm ppc sparc x86"
IUSE="nls"

RDEPEND=">=media-libs/freetype-2.0.1
	=gnome-base/gnome-vfs-1.0*
	>=media-libs/gdk-pixbuf-0.11.0-r1
	=gnome-base/librsvg-1.0*"

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
