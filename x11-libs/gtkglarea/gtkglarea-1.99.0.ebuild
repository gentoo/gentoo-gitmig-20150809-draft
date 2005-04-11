# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.25 2005/04/11 18:34:14 blubb Exp $

inherit gnome2 gnuconfig multilib

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/libc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	gnuconfig_update
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		libdir=/usr/$(get_libdir) \
		install || die "make install failed"
		dodoc AUTHORS ChangeLog INSTALL NEWS README* docs/*.txt
}
