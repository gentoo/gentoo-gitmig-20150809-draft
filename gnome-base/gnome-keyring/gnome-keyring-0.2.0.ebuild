# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-0.2.0.ebuild,v 1.2 2004/03/23 13:18:16 gustavoz Exp $

inherit gnome2

DESCRIPTION="password and keyring managing daemon"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.3.1
	>=x11-libs/gtk+-2.3.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"
