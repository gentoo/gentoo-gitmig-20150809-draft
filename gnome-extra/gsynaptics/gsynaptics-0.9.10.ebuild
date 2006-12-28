# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gsynaptics/gsynaptics-0.9.10.ebuild,v 1.2 2006/12/28 14:31:13 peper Exp $

inherit gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://gsynaptics.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/22897/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
