# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.84.0.ebuild,v 1.4 2002/03/04 00:47:55 verwilst Exp $

S="${WORKDIR}/GnomeMeeting-${PV}"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/GnomeMeeting-${PV}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

DEPEND="virtual/glibc
	>=gnome-base/gnome-libs-1.4.1.4
	>=dev-libs/pwlib-1.2.12-r2
	>=net-libs/openh323-1.8.0
	>=media-libs/gdk-pixbuf-0.16.0
	>=dev-libs/openssl-0.9.6c
	>=gnome-base/gconf-1.0.8
	>=net-nds/openldap-2.0.21
	>=x11-libs/gtk+-1.2.10"


src_compile() {

	cd ${S}
	./configure --prefix=/usr --host=${CHOST} || die
	make || die

}

src_install() {

	make DESTDIR=${D} install || die

}
