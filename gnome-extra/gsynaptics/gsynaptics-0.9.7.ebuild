# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gsynaptics/gsynaptics-0.9.7.ebuild,v 1.3 2006/12/01 20:43:48 wolf31o2 Exp $

inherit gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://gsynaptics.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/20002/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6.0
		>=gnome-base/libglade-2
		>=gnome-base/libgnomeui-2"
RDEPEND="${DEPEND}
		 >=dev-util/pkgconfig-0.19
		 sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_postinst() {
	gnome2_pkg_postinst

	echo
	einfo "Ensure that the following line is in the InputDevice section in"
	einfo "your X config file (/etc/X11/xorg.conf):"
	einfo
	einfo "Option \"SHMConfig\" \"on\""
	einfo
	echo
	einfo "You need to add gsynaptics-init to your session to restore your"
	einfo "settings the next time you log into GNOME:"
	einfo "Desktop -> Preferences -> Sessions -> Start Programs -> Add"
	echo
}
