# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gauche-gtk/gauche-gtk-0.3.1.ebuild,v 1.2 2004/02/04 12:43:15 hattya Exp $

inherit eutils

IUSE="opengl"

MY_P="${P/g/G}"

DESCRIPTION="GTK2 binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND=">=x11-libs/gtk+-2*
	>=dev-lisp/gauche-0.7.2
	opengl? ( >=x11-libs/gtkglext-0.6.0 )"

src_compile() {

	local myconf myflags

	use opengl && myconf="--enable-gtkgl"


	myflags=${CFLAGS}
	unset CFLAGS CXXFLAGS

	econf ${myconf} || die
	emake stubs || die
	emake OPTFLAGS="${myflags}" || die

}

src_install() {

	dodir $(gauche-config --syslibdir)
	dodir $(gauche-config --sysincdir)
	dodir $(gauche-config --sysarchdir)

	make DESTDIR=${D} install || die

	dodoc ChangeLog README COPYING


	docinto examples
	for f in examples/*; do
		[ -f ${f} ] && dodoc ${f}
	done

	docinto examples/gtk-tutorial
	dodoc examples/gtk-tutorial/*

	if use opengl; then
		docinto examples/gtkglext
		dodoc examples/gtkglext/*
	fi

}

pkg_postinst() {

	if use opengl; then
		einfo "If you want to use OpenGL with Gauche, please emerge Gauche-gl."
	fi

}
