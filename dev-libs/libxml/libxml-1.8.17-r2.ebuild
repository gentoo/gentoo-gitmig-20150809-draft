# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.17-r2.ebuild,v 1.25 2004/11/08 14:29:19 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Version 1 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"
SRC_URI="ftp://xmlsoft.org/old/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2"

DEPEND="${RDEPEND}
	>=sys-libs/readline-4.1"

src_compile() {
	append-ldflags -lncurses
	econf || die
	emake -j1 || die # Doesn't work with -j 4 (hallski)
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

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() {
	if [ -e ${ROOT}/usr/include/gnome-xml/libxml ]
	then
		rm -f ${ROOT}/usr/include/gnome-xml/libxml
	fi
}
