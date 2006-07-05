# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.30 2006/07/05 05:26:42 vapier Exp $

inherit gnome2 multilib

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="virtual/libc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README* docs/*.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if [ $(get_libdir) != "lib" ] ; then
		libtoolize --copy --force || die "libtoolize failed"
		aclocal || die "aclocal failed"
		autoconf || die "autoconf failed"
	fi
}

src_install() {
	gnome2_src_install
}
