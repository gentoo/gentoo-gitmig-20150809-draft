# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.8.2.ebuild,v 1.7 2005/04/02 04:38:28 geoman Exp $

inherit gnome2

DESCRIPTION="user interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.4
	=gnome-base/libgnomeprint-${PV}*
	>=gnome-base/libgnomecanvas-2
	>=x11-themes/gnome-icon-theme-1.1.92"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
