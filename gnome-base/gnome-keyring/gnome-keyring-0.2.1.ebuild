# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-0.2.1.ebuild,v 1.6 2004/07/28 02:49:07 tgall Exp $

inherit gnome2

DESCRIPTION="password and keyring managing daemon"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa amd64 ~ia64 ~mips ppc64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.3.1
	>=x11-libs/gtk+-2.3.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"
