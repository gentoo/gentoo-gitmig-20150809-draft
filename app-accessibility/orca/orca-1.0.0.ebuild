# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/orca/orca-1.0.0.ebuild,v 1.1 2006/11/03 04:35:32 leonardop Exp $

inherit gnome2

DESCRIPTION="Extensible screen reader that provides access to the desktop"
HOMEPAGE="http://www.gnome.org/projects/orca/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10
	>=gnome-base/orbit-2
	>=gnome-extra/at-spi-1.7.6
	>=gnome-base/libbonobo-2.14
	>=dev-lang/python-2.4
	>=dev-python/gnome-python-2.14
	>=dev-python/pyorbit-2.14
	>=app-accessibility/gnome-speech-0.3.10
	>=app-accessibility/gnome-mag-0.12.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
