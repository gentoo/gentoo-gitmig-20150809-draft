# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.60.0.ebuild,v 1.7 2008/05/18 17:21:16 drac Exp $

inherit eutils fdo-mime

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="http://gforge.lug.fi.uba.ar/frs/download.php/84/${P}.tar.bz2"
HOMEPAGE="http://oregano.gforge.lug.fi.uba.ar/"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.20
	>=app-text/scrollkeeper-0.3.14
	>=x11-libs/gtk+-2.8
	>=gnome-base/libglade-2.5
	>=gnome-base/libgnome-2.12
	>=gnome-base/libgnomeui-2.12
	>=gnome-base/libgnomecanvas-2.12
	>=gnome-base/libgnomeprint-2.12
	>=gnome-base/libgnomeprintui-2.12
	>=x11-libs/cairo-1.0.0
	=x11-libs/gtksourceview-1*"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.1
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-dont-run-update-mime-database.patch
	epatch "${FILESDIR}"/${P}-install-icon.patch
}

src_compile() {
	scons --cache-disable \
		PREFIX=/usr \
		|| die "scons make failed"
}

src_install() {
	scons --cache-disable DESTDIR="${D}" PREFIX=/usr install \
	|| die "scons install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "You'll need to emerge your prefered simulation backend"
	elog "such as spice, ng-spice-rework or gnucap for simulation"
	elog "to work."
}
