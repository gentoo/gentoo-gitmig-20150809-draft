# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/poedit/poedit-1.1.8.ebuild,v 1.3 2002/08/16 04:04:42 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.bz2"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=x11-libs/wxGTK-2.3.2
	>=sys-libs/db-3"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 <${FILESDIR}/${P}-gentoo.diff

}

src_compile() {
	
	autoconf
	automake
	econf || die
	emake || die
}

src_install () {
	
	einstall \
		DESTDIR=${D} \
		datadir=${D}/usr/share \
		GNOME_DATA_DIR=${D}/usr/share || die

	dodoc AUTHORS LICENSE NEWS README TODO
}
