# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul_status_applet/imhangul_status_applet-0.2-r1.ebuild,v 1.5 2003/09/06 22:19:22 msterret Exp $

inherit gnome2
S=${WORKDIR}/${P}
DESCRIPTION="Status Applet for imhangul"
HOMEPAGE="http://imhangul.kldp.net/"
SRC_URI="http://download.kldp.net/imhangul/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=app-i18n/imhangul-0.9.4"

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
