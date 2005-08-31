# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.6.5.ebuild,v 1.2 2005/08/31 12:11:44 seemant Exp $

inherit gnome2 virtualx

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc static"

RDEPEND=">=dev-libs/atk-1.7.2
	>=gnome-base/libbonobo-1.107
	>=gnome-base/gail-1.3
	>=x11-libs/gtk+-2
	dev-libs/popt
	>=gnome-base/orbit-2
	virtual/x11"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_test() {
	Xmake check || die
}
