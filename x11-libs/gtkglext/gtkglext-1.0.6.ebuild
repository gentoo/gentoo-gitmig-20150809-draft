# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-1.0.6.ebuild,v 1.8 2004/11/12 21:48:57 eradicator Exp $

inherit gnome2

DESCRIPTION="GL extensions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
LICENSE="GPL-2 LGPL-2.1"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86 sparc ~alpha ppc ~ia64 amd64"

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
	if [ -e /etc/env.d/09opengl ]
	then
		# Set up X11 implementation
		X11_IMPLEM_P="$(portageq best_version "${ROOT}" virtual/x11)"
		X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
		X11_IMPLEM="${X11_IMPLEM##*\/}"
		einfo "X11 implementation is ${X11_IMPLEM}."

		VOID=$(cat /etc/env.d/09opengl | grep ${X11_IMPLEM})

		USING_X11=$?
		if [ ${USING_X11} -eq 1 ]
		then
			GL_IMPLEM=$(cat /etc/env.d/09opengl | cut -f5 -d/)
			opengl-update ${X11_IMPLEM}
		fi
	else
		die "Could not find /etc/env.d/09opengl. Please run opengl-update."
	fi
}

pkg_postinst () {
	if [ ${USING_X11} -eq 1 ]
	then
		opengl-update ${GL_IMPLEM}
	fi
}

