# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gail/gail-1.8.0.ebuild,v 1.7 2004/12/11 09:30:37 kloeri Exp $

inherit gnome2

DESCRIPTION="Accessibility support for Gtk+ and libgnomecanvas"
HOMEPAGE="http://developer.gnome.org/projects/gap"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64 ~arm"
IUSE="doc"

USE_DESTDIR="1"

RDEPEND=">=x11-libs/gtk+-2.3.5
	>=dev-libs/atk-1.7
	>=gnome-base/libgnomecanvas-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README"
