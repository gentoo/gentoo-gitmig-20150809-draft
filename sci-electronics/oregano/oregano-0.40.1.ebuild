# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.40.1.ebuild,v 1.2 2005/01/25 22:38:39 gustavoz Exp $

inherit eutils

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="http://gforge.lug.fi.uba.ar/frs/download.php/50/${P}.tar.bz2"
HOMEPAGE="http://oregano.gforge.lug.fi.uba.ar/"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.0
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeprint-2.4
	>=gnome-base/libgnomeprintui-2.4
	>=x11-libs/cairo-0.1.23-r1
	>=x11-libs/gtksourceview-1.0"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "You'll need to emerge your prefered simulation backend"
	einfo "such as spice, ng-spice-rework or gnucap for simulation"
	einfo "to work."
	einfo
	ebeep 5
	epause 3
}
