# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gal/gal-0.11.ebuild,v 1.2 2001/08/31 21:47:40 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Application Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=dev-util/xml-i18n-tools-0.8.4 sys-devel/perl
        >=gnome-base/gnome-vfs-1.0.1
	>=gnome-base/libunicode-0.4
        alsa? ( >=media-libs/alsa-lib-0.5.10 )
	>=gnome-base/gnome-print-0.24
	>=gnome-base/libglade-0.13
	>=gnome-base/libxml-1.8.8"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
		    --sysconfdir=/etc/opt/gnome ${myconf} || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}





