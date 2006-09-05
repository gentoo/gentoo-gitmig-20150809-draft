# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-1.1.1.ebuild,v 1.12 2006/09/05 02:55:17 kumba Exp $

inherit gnome2

DESCRIPTION="GAIL libraries for Gnome2 "
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="static"
RESTRICT=test

RDEPEND=">=dev-libs/atk-1.7.2
	>=gnome-base/gnome-panel-0.0.18
	>=gnome-base/libbonoboui-1.1
	>=gnome-base/libbonobo-1.1
	>=gnome-base/libgnomeui-1.1
	>=gnome-extra/at-spi-0.10
	>=x11-libs/gtk+-1.3.11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable static)"
