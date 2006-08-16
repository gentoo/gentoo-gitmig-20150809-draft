# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.11.4.ebuild,v 1.12 2006/08/16 15:03:09 corsair Exp $

inherit gnome2 autotools

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.5.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack

	# fix mismatch that some people run into while merging, #132139
	# we copy aclocal to old_macros to include the gtk-doc macros.
	cp aclocal.m4 old_macros.m4
	sed -i -e 's:AM_INIT_AUTOMAKE:AM_INIT_AUTOMAKE2:' old_macros.m4
	sed -i -e 's:AM_AUTOMAKE_VERSION:AM_AUTOMAKE_VERSION2:' old_macros.m4
	sed -i -e 's:AM_SET_CURRENT_AUTOMAKE_VERSION:AM_SET_CURRENT_AUTOMAKE_VERSION2:' old_macros.m4
	AT_M4DIR="." eautoreconf
}
