# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul-status-applet/imhangul-status-applet-0.3.ebuild,v 1.1 2004/10/06 07:55:09 usata Exp $

inherit gnome2

MY_P=${PN//-/_}-${PV}

DESCRIPTION="Status Applet for imhangul"
HOMEPAGE="http://imhangul.kldp.net/"
SRC_URI="http://download.kldp.net/imhangul/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=app-i18n/imhangul-0.9.4"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
