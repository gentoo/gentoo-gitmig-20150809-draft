# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/fontilus/fontilus-0.4.ebuild,v 1.2 2004/01/02 19:51:21 aliz Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Fontviewer for Nautilus"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

RDEPEND="virtual/xft
	>=gnome-base/gnome-vfs-2
	!<gnome-base/gnome-2.0.3-r1"
#	>=media-libs/fontconfig-2

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
