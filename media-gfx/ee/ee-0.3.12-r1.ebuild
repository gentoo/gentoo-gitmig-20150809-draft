# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="ee"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"


src_compile() {

	./configure --host=${CHOST}					\
		    --prefix=/usr || die

	emake || die
}

src_install() {

	# .mo-files doesn't work with DESTDIR, *grr*
	make DESTDIR=${D} 						\
	     prefix=${D}/usr						\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
