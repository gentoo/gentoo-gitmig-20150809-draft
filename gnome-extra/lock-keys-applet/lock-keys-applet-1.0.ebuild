# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/lock-keys-applet/lock-keys-applet-1.0.ebuild,v 1.15 2010/12/08 17:32:23 pacho Exp $

EAPI="3"
inherit autotools gnome2 eutils

DESCRIPTION="An applet that shows the status of your Caps, Num and Scroll Lock keys"
HOMEPAGE="http://mfcn.ilo.de/led_applet"
SRC_URI="http://mfcn.ilo.de/led_applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# remove deprecated definitions, bug #206459
	# courtesy of ubuntu/debian developers
	epatch "${FILESDIR}/${P}-gtk-disable-deprecated.patch"

	# Fix intltool tests
	echo "GNOME_LockKeysApplet.server.in" >> po/POTFILES.in

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautomake
}
