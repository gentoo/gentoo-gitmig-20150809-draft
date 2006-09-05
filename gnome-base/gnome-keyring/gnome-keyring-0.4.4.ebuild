# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-0.4.4.ebuild,v 1.8 2006/09/05 02:00:22 kumba Exp $

inherit gnome2

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="static"

RDEPEND=">=dev-libs/glib-2.3.1
	>=x11-libs/gtk+-2.6.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"
G2CONF="${G2CONF} $(use_enable static)"
