# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.17-r1.ebuild,v 1.2 2002/07/11 06:30:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=sys-libs/ncurses-5.2"

DEPEND="${RDEPEND}
        >=sys-libs/readline-4.1"


src_compile() {
	LDFLAGS="-lncurses" \
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make DESTDIR=${D} \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die

	# This link must be fixed
	rm ${D}/usr/include/gnome-xml/libxml
	dosym /usr/include/gnome-xml /usr/include/gnome-xml/libxml
	
	dodoc AUTHORS COPYING* ChangeLog NEWS README
}







