# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-webcal/evolution-webcal-2.0.1.ebuild,v 1.6 2004/11/16 10:33:12 kloeri Exp $

inherit gnome2

DESCRIPTION="A GNOME URL handler for web-published ical calendar files"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~amd64 ppc sparc ~mips ~hppa ~ia64 ~alpha"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2
	>=gnome-extra/evolution-data-server-1.0.2
	>=net-libs/libsoup-2.2.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"
