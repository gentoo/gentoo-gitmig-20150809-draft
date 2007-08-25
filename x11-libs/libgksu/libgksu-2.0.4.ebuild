# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-2.0.4.ebuild,v 1.8 2007/08/25 13:55:41 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE="nls doc"

DEPEND="doc? ( >=dev-util/gtk-doc-1.2-r1 )
	nls? ( >=sys-devel/gettext-0.14.1 )
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-keyring-0.4.4
	x11-libs/startup-notification
	>=gnome-base/libgtop-2
	>=gnome-base/libglade-2"
RDEPEND="${DEPEND}
	app-admin/sudo
	dev-util/intltool
	>=dev-util/pkgconfig-0.19"

USEDESTDIR="1"
G2CONF="$(use_enable nls)"
DOCS="AUTHORS ChangeLog"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${PN}-2.0.0-fbsd.patch
}
