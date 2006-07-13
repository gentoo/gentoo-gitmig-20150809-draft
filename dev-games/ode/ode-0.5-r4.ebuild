# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.5-r4.ebuild,v 1.5 2006/07/13 02:27:13 agriffis Exp $

inherit eutils

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~sparc x86"
IUSE="doc debug double-precision"

RDEPEND="virtual/opengl
	|| (
		(
			x11-libs/libX11
			virtual/glut )
		virtual/x11 )
	virtual/glu"

DEPEND="${RDEPEND}
	|| (
		x11-proto/xproto
		virtual/x11 )"

config_use() {
	use $1 && echo $2 || echo $3
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo 'C_FLAGS+=$(E_CFLAGS) -fPIC' >> config/makefile.unix-gcc
	epatch "${FILESDIR}"/${P}-PIC.patch
	sed -i -e "s/..\/..\/drawstuff\/textures/\/usr\/share\/${PF}\/examples/" ode/test/*.c*
	sed -i -e "s/fn.path_to_textures = 0/fn.path_to_textures = \"\/usr\/share\/${PF}\/examples\"/" drawstuff/dstest/dstest.cpp
	sed -i \
		-e "s/#OPCODE_DIRECTORY/OPCODE_DIRECTORY/" \
		-e "/^BUILD=/s:=.*:=$(config_use debug debug release):" \
		-e "/^PRECISION=/s:=.*:=$(config_use double-precision DOUBLE SINGLE):" \
		config/user-settings
	sed -i -e "s/inline_[\t]*void[\t*]ResetCountDown/void ResetCountDown/" OPCODE/OPC_TreeCollider.h
}

src_compile() {
	emake \
		-j1 \
		E_CFLAGS="${CFLAGS}" \
		PLATFORM=unix-gcc \
		|| die "emake failed"
}

src_install() {
	insinto /usr/include/ode
	doins include/ode/*.h || die "doins failed"
	insinto /usr/include/drawstuff
	doins include/drawstuff/*.h || die "doins failed"
	dolib lib/libode.a lib/libdrawstuff.a || die "dolib failed"
	dodir /usr/share/${P}/config
	insinto /usr/share/${P}/config
	doins config/user-settings
	if use doc; then
		dodoc README CHANGELOG ode/doc/ode.pdf
		dohtml ode/doc/ode.html
		dodir /usr/share/doc/${PF}/html/pix/
		insinto /usr/share/doc/${PF}/html/pix/
		doins ode/doc/pix/*.jpg
		# install examples
		dodir /usr/share/${PF}/examples
		exeinto /usr/share/${PF}/examples
		doexe ode/test/*.exe
		doexe drawstuff/dstest/dstest.exe
		insinto /usr/share/${PF}/examples
		doins ode/test/*.c ode/test/*.cpp
		doins drawstuff/textures/*.ppm
		doins drawstuff/dstest/dstest.cpp
	fi
}
