# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-1.0.1-r1.ebuild,v 1.1 2002/03/10 08:38:13 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-mime-data"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-util/pkgconfig-0.8.0
		nls? ( >=dev-util/intltool-0.11 )"

src_compile() {
	
	local myconf

	use nls || myconf="${myconf} --disable-nls"

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
	     localstatedir=${D}/var/lib	\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
