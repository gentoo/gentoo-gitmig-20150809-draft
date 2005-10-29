# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooqstart-gnome/ooqstart-gnome-0.8.3-r1.ebuild,v 1.1 2005/10/29 22:20:37 suka Exp $

inherit eutils

DESCRIPTION="OpenOffice.org Quickstarter Applet for Gnome 2.x"
HOMEPAGE="http://ooqstart.sourceforge.net/"
MY_P="ooqstart-${PV}"
SRC_URI="mirror://sourceforge/ooqstart/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

RDEPEND=">=virtual/ooo-2.0.0
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gnome2update-2.0.patch.bz2
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-options-2.0.diff
	epatch ${FILESDIR}/${P}-optflags.diff
}

src_install() {
	make ROOT=${D} install-gnome || die
}

pkg_postinst() {
	einfo " If you are you using openoffice-bin-2.0.0 and don't get any icons, "
	einfo " please re-merge openoffice-bin, there have recently been some "
	einfo " modifications to it, which solve this. "
}
