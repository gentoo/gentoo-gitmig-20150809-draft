# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooqstart-gnome/ooqstart-gnome-0.8.3.ebuild,v 1.2 2005/01/16 15:15:11 suka Exp $

inherit gnome2 eutils

DESCRIPTION="OpenOffice.org Quickstarter Applet for Gnome 2.x"
HOMEPAGE="http://ooqstart.sourceforge.net/"
SRC_URI="mirror://sourceforge/ooqstart/ooqstart-${PV}.tgz"
S=${WORKDIR}/ooqstart-${PV}

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gnome2update.patch.bz2
}

src_compile() {
	make DESTDIR=${D} || die "make failed"
}

src_install() {
	make ROOT=${D} install-gnome || die
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/gnome-ooqstart.png
}

pkg_postinst() {
	einfo "If you are you using openoffice-ximian please correct"
	einfo "the path in the preferences of the applet to"
	einfo "'/usr/bin/xooffice' after the first start"
}
