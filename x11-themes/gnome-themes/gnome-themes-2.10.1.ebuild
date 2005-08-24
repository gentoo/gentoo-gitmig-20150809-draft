# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.10.1.ebuild,v 1.9 2005/08/24 01:17:21 vapier Exp $

# FIXME : the engines in here should probably be disabled and done in seperate ebuilds

inherit gnome2

DESCRIPTION="A set of gnome2 themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/gnome-themes"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2.6
	>=x11-themes/gtk-engines-2.5"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} $(use_enable accessibility all-themes)"
DOCS="AUTHORS README NEWS ChangeLog"

pkg_postinst() {
	einfo "Updating Icon Cache"

	if use accessibility; then
		gtk-update-icon-cache -qf /usr/share/icons/LowContrastLargePrint
		gtk-update-icon-cache -qf /usr/share/icons/HighContrastLargePrint
		gtk-update-icon-cache -qf /usr/share/icons/HighContrastLargePrintInverse
	fi

	gtk-update-icon-cache -qf /usr/share/icons/Crux
	gtk-update-icon-cache -qf /usr/share/icons/Flat-Blue
	gtk-update-icon-cache -qf /usr/share/icons/Sandy
	gtk-update-icon-cache -qf /usr/share/icons/Smokey-Blue
	gtk-update-icon-cache -qf /usr/share/icons/Smokey-Red
}
