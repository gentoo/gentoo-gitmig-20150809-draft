# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-0.3.1.ebuild,v 1.1 2002/09/06 03:57:05 spider Exp $ 


inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="an editor to the GConf2 system"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/glib-2.0.6-r1"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS"
