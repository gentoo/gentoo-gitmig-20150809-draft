# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gail/gail-1.4.1.ebuild,v 1.10 2004/11/08 20:00:42 vapier Exp $

inherit gnome2

DESCRIPTION="Part of Gnome Accessibility"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips arm"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.1.3
	>=dev-libs/atk-1.3
	>=gnome-base/libgnomecanvas-2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS"

