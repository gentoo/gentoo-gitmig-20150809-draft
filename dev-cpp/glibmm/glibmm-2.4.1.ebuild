# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glibmm/glibmm-2.4.1.ebuild,v 1.9 2004/07/14 02:18:57 lv Exp $

inherit gnome2

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86 ~ppc amd64"
IUSE=""

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RDEPEND=">=dev-libs/libsigc++-2.0
		>=dev-libs/glib-2.4"

src_compile () {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal -I scripts
		automake -c -f
		autoconf
	fi
	gnome2_src_compile
}

DOCS="AUTHORS CHANGES ChangeLog HACKING PORTING NEWS README TODO"

