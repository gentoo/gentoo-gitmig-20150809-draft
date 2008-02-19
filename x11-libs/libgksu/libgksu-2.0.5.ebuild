# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-2.0.5.ebuild,v 1.11 2008/02/19 00:44:49 dang Exp $

inherit gnome2 eutils

DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="nls doc"

BOTH=">=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-keyring-0.4.4
	x11-libs/startup-notification
	>=gnome-base/libgtop-2
	>=gnome-base/libglade-2
	nls? ( >=sys-devel/gettext-0.14.1 )"

DEPEND="${BOTH}
	doc? ( >=dev-util/gtk-doc-1.2-r1 )
	dev-util/intltool
	>=dev-util/pkgconfig-0.19"

RDEPEND="${BOTH}
	app-admin/sudo"

USEDESTDIR="1"
G2CONF="$(use_enable nls)"
DOCS="AUTHORS ChangeLog"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${PN}-2.0.0-fbsd.patch
}
