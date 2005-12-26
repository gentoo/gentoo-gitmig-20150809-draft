# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-0.4.4.ebuild,v 1.7 2005/12/26 15:41:51 kloeri Exp $

inherit gnome2

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="static"

RDEPEND=">=dev-libs/glib-2.3.1
	>=x11-libs/gtk+-2.6.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"
G2CONF="${G2CONF} $(use_enable static)"
