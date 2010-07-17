# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.69.0.ebuild,v 1.4 2010/07/17 17:12:33 armin76 Exp $

inherit eutils fdo-mime

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="http://gforge.lug.fi.uba.ar/frs/download.php/86/${P}.tar.gz"
HOMEPAGE="http://oregano.gforge.lug.fi.uba.ar/"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc sparc x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2.5
	>=gnome-base/libgnome-2.12
	>=gnome-base/libgnomeui-2.12
	>=gnome-base/libgnomecanvas-2.12
	>=gnome-base/libgnomeprint-2.12
	>=x11-libs/cairo-1.2
	=x11-libs/gtksourceview-1*"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.1
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.60.0-dont-run-update-mime-database.patch
}

src_compile() {
	scons --cache-disable \
		PREFIX=/usr \
		|| die "scons make failed"
}

src_install() {
	scons --cache-disable DESTDIR="${D}" PREFIX=/usr install \
	|| die "scons install failed"
	dodoc AUTHORS INSTALL NEWS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "You'll need to emerge your prefered simulation backend"
	elog "such as spice, ng-spice-rework or gnucap for simulation"
	elog "to work."
}
