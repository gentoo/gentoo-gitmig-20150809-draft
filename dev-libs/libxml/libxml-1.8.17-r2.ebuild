# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.17-r2.ebuild,v 1.19 2004/01/10 02:55:47 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Version 1 of the library to manipulate XML files."
SRC_URI="ftp://xmlsoft.org/old/${P}.tar.gz"
HOMEPAGE="http://www.xmlsoft.org/"

SLOT="1"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

RDEPEND=">=sys-libs/ncurses-5.2"

DEPEND="${RDEPEND}
	>=sys-libs/readline-4.1"

src_compile() {
	LDFLAGS="-lncurses" econf || die

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

pkg_preinst() {
	if [ -e ${ROOT}/usr/include/gnome-xml/libxml ]
	then
		rm -f ${ROOT}/usr/include/gnome-xml/libxml
	fi
}
