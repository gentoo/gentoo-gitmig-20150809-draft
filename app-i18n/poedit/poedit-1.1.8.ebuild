# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.1.8.ebuild,v 1.1 2004/07/27 00:03:27 pythonhead Exp $

inherit eutils

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.bz2"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.3.2
	>=sys-libs/db-3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	# fixes bug 16713
	epatch ${FILESDIR}/${P}-gcc3.patch
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
