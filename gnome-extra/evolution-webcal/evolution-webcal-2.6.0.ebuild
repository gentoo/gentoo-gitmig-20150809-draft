# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-webcal/evolution-webcal-2.6.0.ebuild,v 1.10 2006/10/20 21:32:24 agriffis Exp $

inherit gnome2

DESCRIPTION="A GNOME URL handler for web-published ical calendar files"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=net-libs/libsoup-2.2
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2
	>=gnome-extra/evolution-data-server-1.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog TODO"
