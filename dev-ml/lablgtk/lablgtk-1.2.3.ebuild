# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-1.2.3.ebuild,v 1.9 2004/01/22 22:30:43 mattam Exp $

IUSE="gnome opengl"

DESCRIPTION="Objective CAML interface for Gtk+"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgtk.html"
LICENSE="LGPL-2.1 as-is"

DEPEND=">=x11-libs/gtk+-1.2.10-r7
	>=dev-lang/ocaml-3.04
	gnome? ( >=gnome-base/libglade-0.17-r6
	         >=gnome-base/gnome-libs-1.4.1.7 )
	opengl? ( >=dev-ml/lablgl-0.97 >=x11-libs/gtkglarea-1.2.3 )"

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/lablgtk-${PV}.tar.gz"
S=${WORKDIR}/${P}
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc"

Name="LablGTK"

src_unpack() {
	unpack ${A}

	# patch the makefile to include DESTDIR support
	cd ${S} || die
	patch -p0 < ${FILESDIR}/${Name}-${PV}-Makefile-destdir.patch || die
}

src_compile() {

	local myconf

	if [ `use gnome` ]; then
		myconf="$myconf USE_GNOME=1 USE_GLADE=1"
	fi

	if [ `use opengl` ]; then
		myconf="$myconf USE_GL=1"
	fi

	make configure $myconf || die "./configure failed"
	make all opt || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES COPYING README
}
