# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul-status-applet/imhangul-status-applet-0.2-r1.ebuild,v 1.5 2009/12/31 21:05:46 ssuominen Exp $

inherit gnome2

MY_P=${PN//-/_}-${PV}

DESCRIPTION="Status Applet for imhangul"
HOMEPAGE="http://imhangul.kldp.net/"
SRC_URI="http://kldp.net/frs/download.php/192/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=app-i18n/imhangul-0.9.4
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
