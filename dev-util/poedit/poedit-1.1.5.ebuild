# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/poedit/poedit-1.1.5.ebuild,v 1.4 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."

SRC_URI="mirror://sourceforge/poedit/${P}.tar.bz2"

HOMEPAGE="http://poedit.sourceforge.net/"

DEPEND=">=x11-libs/wxGTK-2.3.2
	>=sys-libs/db-3"

src_unpack() {

    unpack ${A}
    cd ${S}
    patch -p0 <${FILESDIR}/${P}-gentoo.diff

}

src_compile() {
 
	./configure --host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--datadir=/usr/share
	assert

	emake || die
}

src_install () {
	
	make prefix=${D}/usr DESTDIR=${D} \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		GNOME_DATA_DIR=${D}/usr/share \
		install || die

	dodoc AUTHORS LICENSE NEWS README TODO
}
