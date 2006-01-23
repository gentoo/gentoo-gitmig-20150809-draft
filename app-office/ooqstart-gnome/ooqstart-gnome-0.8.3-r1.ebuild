# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooqstart-gnome/ooqstart-gnome-0.8.3-r1.ebuild,v 1.3 2006/01/23 15:05:44 suka Exp $

inherit eutils

DESCRIPTION="OpenOffice.org Quickstarter Applet for Gnome 2.x"
HOMEPAGE="http://ooqstart.sourceforge.net/"
MY_P="ooqstart-${PV}"
SRC_URI="mirror://sourceforge/ooqstart/${MY_P}.tgz
	mirror://gentoo/${PN}-2.patch.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
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
	epatch ${DISTDIR}/${PN}-2.patch.bz2
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-options-2.0.diff
	epatch ${FILESDIR}/${P}-optflags.diff
}

src_install() {
	make ROOT=${D} install-gnome || die
}
