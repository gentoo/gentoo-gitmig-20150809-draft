# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.40.5.ebuild,v 1.7 2008/04/21 14:38:09 calchan Exp $

inherit eutils

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="http://gforge.lug.fi.uba.ar/frs/download.php/64/${P}.tar.bz2"
HOMEPAGE="http://oregano.gforge.lug.fi.uba.ar/"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.20
	>=app-text/scrollkeeper-0.3.14
	>=x11-libs/gtk+-2.8
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnome-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/libgnomecanvas-2.10
	>=gnome-base/libgnomeprint-2.10
	>=gnome-base/libgnomeprintui-2.10
	>=x11-libs/cairo-1.0.0
	=x11-libs/gtksourceview-1*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	elog "You'll need to emerge your prefered simulation backend"
	elog "such as spice, ng-spice-rework or gnucap for simulation"
	elog "to work."
}
