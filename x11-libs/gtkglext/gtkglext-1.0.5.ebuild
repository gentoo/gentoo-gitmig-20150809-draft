# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-1.0.5.ebuild,v 1.2 2004/03/13 22:01:21 dholm Exp $

inherit gnome2

DESCRIPTION="GL extentions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
LICENSE="GPL-2 LGPL-2.1"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README* TODO"

# gtkglext doesn't build with some (faulty) nvidia drivers headers
# this makes it always switch to xfree during install
# foser <foser@gentoo.org>

pkg_setup () {
	VOID=`cat /etc/env.d/09opengl | grep xfree`

	USING_NVIDIA=$?

	if [ ${USING_NVIDIA} -eq 1 ]
	then
		opengl-update xfree
	fi
}

pkg_postinst () {
	if [ ${USING_NVIDIA} -eq 1 ]
	then
		opengl-update nvidia
	fi
}

