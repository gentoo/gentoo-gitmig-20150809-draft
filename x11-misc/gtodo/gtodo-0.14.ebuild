# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtodo/gtodo-0.14.ebuild,v 1.9 2005/01/01 15:54:44 josejx Exp $

inherit debug flag-o-matic gnome2

strip-flags

IUSE="gnome"

DESCRIPTION="Gtodo is a Gtk+-2.0 Todo list manager written for use with gnome 2."
HOMEPAGE="http://gtodo.qballcow.nl/"
SRC_URI="mirror://sourceforge/gtodo/${P}.tar.gz
	gnome? ( http://download.qballcow.nl/programs/${PN}/${PN}-applet-0.1.tar.gz )"
KEYWORDS="x86 amd64 ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/libxml2-2.5.8
	>=gnome-base/gconf-2.0
	>=dev-libs/glib-2.0
	dev-util/pkgconfig
	>=gnome-base/gnome-vfs-2.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_compile(){
	econf || die "econf failed"
	emake || die "emake failed"

	# Gnome Applet
	use gnome && (
		einfo "Building Gnome Applet..."
		cd ${S}/../gtodo-applet-0.1
		econf || die "applet econf failed"
		emake || die "applet emake failed"
	)
}

src_install(){
	addwrite /etc/gconf
	einstall || die "einstall failed"

	# Install Gnome Applet
	use gnome && (
		einfo "Installing Gnome Applet..."
		cd ${S}/../gtodo-applet-0.1
		einstall || die "applet einstall failed"
	)
}
