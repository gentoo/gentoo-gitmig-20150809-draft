# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/glibwww/glibwww-0.2-r1.ebuild,v 1.6 2001/08/31 23:32:48 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome WWW Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=net-libs/libwww-1.5.3-r1
	 >=gnome-base/gnome-libs-1.2.13
	 gnome-base/gnome-env"

DEPEND="${RDEPEND}"

src_compile() {
	./configure --host=${CHOST} --prefix=/opt/gnome || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
}
