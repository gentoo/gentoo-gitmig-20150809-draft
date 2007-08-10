# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.18.0.ebuild,v 1.5 2007/08/10 13:22:06 angelos Exp $

inherit gnome2

DESCRIPTION="User interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ~ppc64 ~sh sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeprint-2.12.1
	>=gnome-base/libgnomecanvas-1.117
	>=x11-themes/gnome-icon-theme-1.1.92"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
