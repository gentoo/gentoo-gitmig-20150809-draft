# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.7-r1.ebuild,v 1.1 2001/11/05 22:27:28 azarah Exp $

P=GConf-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="GConf is a configuration storage system."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/GConf/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=sys-libs/db-3.2.3h
	>=dev-libs/libxml-1.8.16
	>=dev-libs/popt-1.5
	>=gnome-base/ORBit-0.5.11
	>=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        >=dev-util/guile-1.4"


src_compile() {

	local myconf
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	make || die   # Doesn't work with -j 4 (hallski)
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
