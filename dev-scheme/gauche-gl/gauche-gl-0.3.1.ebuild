# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gl/gauche-gl-0.3.1.ebuild,v 1.3 2004/07/16 09:42:10 dholm Exp $

inherit eutils flag-o-matic

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="OpenGL binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

RESTRICT="nomirror"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="virtual/opengl
	>=media-libs/glut-3.7
	>=dev-lang/gauche-0.7.3"

src_compile() {

	local myflags

	filter-flags -fforce-addr

	myflags=${CFLAGS}
	unset CFLAGS CXXFLAGS

	econf || die
	emake OPTFLAGS="${myflags}" || die

}

src_install() {

	dodir $(gauche-config --syslibdir)
	dodir $(gauche-config --sysincdir)
	dodir $(gauche-config --sysarchdir)

	make DESTDIR=${D} install || die

	dodoc README ChangeLog INSTALL* COPYING

	docinto examples
	dodoc examples/*.scm

	docinto examples/glbook
	dodoc examples/glbook/*

}
