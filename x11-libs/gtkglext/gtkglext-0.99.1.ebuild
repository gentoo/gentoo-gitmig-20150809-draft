# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-0.99.1.ebuild,v 1.1 2003/05/05 09:48:29 liquidx Exp $

inherit gnome2

IUSE="doc"

DESCRIPTION="GL extentions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl"

DEPEND="${DEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS* README* TODO"


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
