# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.4.1.ebuild,v 1.7 2004/01/18 14:33:47 gustavoz Exp $

inherit gnome2

IUSE="doc"
DESCRIPTION="Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc alpha sparc hppa amd64 ia64"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS"
