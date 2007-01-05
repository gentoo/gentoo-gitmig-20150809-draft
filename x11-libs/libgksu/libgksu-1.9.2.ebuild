# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-1.9.2.ebuild,v 1.11 2007/01/05 18:30:19 dang Exp $

inherit gnome2

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"


DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/old_stuff/${MY_PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="${IUSE} nls doc"

DEPEND="doc? ( >=dev-util/gtk-doc-1.2-r1 )
	nls? ( >=sys-devel/gettext-0.14.1 )
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	x11-libs/startup-notification
	>=gnome-base/gnome-keyring-0.4.4
	>=dev-util/pkgconfig-0.19"

RDEPEND="${DEPEND}
	app-admin/sudo"

USEDESTDIR="1"
G2CONF="$(use_enable nls)"
