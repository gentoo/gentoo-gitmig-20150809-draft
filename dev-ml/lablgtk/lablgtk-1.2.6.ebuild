# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-1.2.6.ebuild,v 1.2 2004/02/17 22:25:11 agriffis Exp $

IUSE="gnome opengl"

DESCRIPTION="Objective CAML interface for Gtk+"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgtk.html"
LICENSE="LGPL-2.1 as-is"

DEPEND="=x11-libs/gtk+-1.2*
		>=dev-lang/ocaml-3.06
		gnome? ( =gnome-base/libglade-0.17*
			>=gnome-base/gnome-libs-1.4.1.7
			media-libs/gdk-pixbuf )
		opengl? ( >=dev-ml/lablgl-0.98
			=x11-libs/gtkglarea-1.2* )"

RDEPEND=${DEPEND}

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/lablgtk-${PV}.tar.gz"
S=${WORKDIR}/${P}
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64"

Name="LablGTK"

src_compile() {

	local myconf="USE_DOTOPT=1 BINDIR=${D}/usr/bin INSTALLDIR=${D}/usr/lib/ocaml/lablgtk DLLDIR=${D}/usr/lib/ocaml/stublibs"

	use gnome && myconf="$myconf USE_GNOME=1 USE_GLADE=1"
	use opengl && myconf="$myconf USE_GL=1"

	make configure $myconf || die "./configure failed"
	make all opt || die
}

src_install () {
	dodir /usr/bin /usr/lib/ocaml/lablgtk /usr/lib/ocaml/stublibs
	make install || die
	dosed /usr/bin/lablgtk
	dodoc CHANGES COPYING README
}

