# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/integrity/integrity-1.0.ebuild,v 1.1 2004/09/07 14:06:24 usata Exp $

IUSE=""

DESCRIPTION="A customizable QT/X11 based window manager."
HOMEPAGE="http://integrity.sourceforge.net"
SRC_URI="mirror://sourceforge/integrity/${P}.tar.gz"

S=${WORKDIR}/${PN}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=x11-libs/qt-3.2.3"

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die "make install failed."

	dodir /usr/share/integrity

	dodir /usr/share/integrity/config
	insinto /usr/share/integrity/config
	newins config/config.xml config.xml.default
	doins config/config.xml
	newins config/deskmenu.xml deskmenu.xml.default
	doins config/deskmenu.xml

	doins config/modules.xml.disabled
	dodir /usr/share/integrity/modules
	insinto /usr/share/integrity/modules
	doins modules/*

	dodir /usr/share/integrity/backgrounds
	insinto /usr/share/integrity/backgrounds
	doins backgrounds/*

	dodir /usr/share/integrity/themes

	#No recursive ability
	cp -r themes/* ${D}/usr/share/integrity/themes

}
