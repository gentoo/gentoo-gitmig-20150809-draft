# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.6.2.ebuild,v 1.2 2004/07/29 02:26:24 tgall Exp $

inherit gnome2

DESCRIPTION="user interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2.1"

SLOT="2.2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ppc64"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.4
	=gnome-base/libgnomeprint-${PV}*
	>=gnome-base/libgnomecanvas-2
	>=x11-themes/gnome-icon-theme-1.2.0"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
