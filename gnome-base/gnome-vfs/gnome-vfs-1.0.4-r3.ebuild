# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.0.4-r3.ebuild,v 1.2 2002/06/04 00:38:29 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Virtual File System."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"

RDEPEND=">=gnome-base/gconf-1.0.4-r2
	 >=gnome-base/gnome-libs-1.4.1.2
	 >=gnome-base/gnome-mime-data-1.0.1
	 >=sys-apps/bzip2-1.0.2
	 ssl? ( dev-libs/openssl )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.8.0
	>=dev-util/intltool-0.11
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
