# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-1.4.0.3.ebuild,v 1.2 2001/08/31 21:55:21 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-applets"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gnome-core-1.4
	>=gnome-base/libgtop-1.0.12
	>=gnome-base/libghttp-1.0.9
        >=gnome-base/scrollkeeper-0.2
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=gnome-base/gnome-core-1.4
	>=gnome-base/libgtop-1.0.12
	>=gnome-base/libghttp-1.0.9"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
	            --sysconfdir=/etc/opt/gnome 			\
		    --infodir=/opt/gnome/share/info ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome	\
	     infodir=${D}/opt/gnome/share/info install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
