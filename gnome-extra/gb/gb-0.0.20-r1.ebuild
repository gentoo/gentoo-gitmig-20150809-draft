# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Basic"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
	 	    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
	assert

	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die 

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}




