# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gb/gb-0.0.20-r1.ebuild,v 1.4 2002/07/25 03:10:32 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Basic"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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




