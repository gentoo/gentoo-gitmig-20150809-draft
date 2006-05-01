# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.7.7.ebuild,v 1.1 2006/05/01 17:48:13 dang Exp $

inherit virtualx gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# >=atk-1.11 required. See
# http://mail.gnome.org/archives/gnome-accessibility-list/2006-February/msg00036.html
RDEPEND=">=dev-libs/atk-1.11
	>=gnome-base/libbonobo-1.107
	>=gnome-base/gail-1.3
	>=x11-libs/gtk+-2
	>=gnome-base/orbit-2
	dev-libs/popt
	|| ( (
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXi
			x11-libs/libXtst )
		virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.31
	doc? ( >=dev-util/gtk-doc-1 )
	|| ( (
			x11-libs/libXt
			x11-proto/xextproto
			x11-proto/inputproto
			x11-proto/xproto )
		virtual/x11 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"


src_test() {
	Xmake check || die "Testing phase failed"
}
