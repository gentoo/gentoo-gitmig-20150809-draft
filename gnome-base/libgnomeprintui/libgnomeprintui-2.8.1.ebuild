# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.8.1.ebuild,v 1.2 2004/12/09 04:55:49 joem Exp $

inherit eutils gnome2

DESCRIPTION="user interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64 ~arm"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.4
	=gnome-base/libgnomeprint-${PV}*
	>=gnome-base/libgnomecanvas-2
	>=x11-themes/hicolor-icon-theme-0.5"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	#Don't require gnome-icon-theme as a build time dep
	#see bug #72901 for more information <joem@gentoo.org>

	epatch ${FILESDIR}/${P}-no-gnome-icon.patch
	autoconf || die "autoconf failed"
}
