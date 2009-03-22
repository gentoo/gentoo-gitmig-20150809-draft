# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-open-terminal/nautilus-open-terminal-0.9-r1.ebuild,v 1.1 2009/03/22 12:20:50 eva Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="Nautilus Plugin for Opening Terminals"
HOMEPAGE="http://manny.cluecoder.org/packages/nautilus-open-terminal/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/eel-2.6
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.13.3
	>=gnome-base/nautilus-2.21.2
	>=gnome-base/gnome-desktop-2.9.91
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.18"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} --disable-static"

src_prepare() {
	gnome2_src_prepare

	# Be a bit more future proof, bug #260903
	sed "s/-Werror//" -i src/Makefile.am src/Makefile.in || die "sed failed"

	# Respect LINGUAS
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautomake
}
