# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.5-r2.ebuild,v 1.4 2005/04/03 16:40:41 chrb Exp $

inherit eutils

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc debug"

DEPEND="virtual/libc
	virtual/x11
	virtual/glu
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo 'C_FLAGS+=$(E_CFLAGS) -fPIC' >> config/makefile.unix-gcc
	epatch "${FILESDIR}"/${PV}-PIC.patch
	sed -i -e "s/#OPCODE_DIRECTORY/OPCODE_DIRECTORY/" config/user-settings
	sed -i -e "s/..\/..\/drawstuff\/textures/\/usr\/share\/${P}\/examples/" ode/test/*.c*
	sed -i -e "s/fn.path_to_textures = 0/fn.path_to_textures = \"\/usr\/share\/${P}\/examples\"/" drawstuff/dstest/dstest.cpp
	if use debug; then
		sed -e "s/#BUILD=d/BUILD=d/" -e "s/BUILD=r/#BUILD=r/" -i ${S}/config/user-settings
	fi
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
	dolib lib/libode.a lib/libdrawstuff.a || die "dolib failed"
	if use doc; then
		dodoc README CHANGELOG ode/doc/ode.pdf
		dohtml ode/doc/ode.html
		dodir /usr/share/doc/${P}/html/pix/
		insinto /usr/share/doc/${P}/html/pix/
		doins ode/doc/pix/*.jpg
		# install examples
		dodir /usr/share/${P}/examples
		exeinto /usr/share/${P}/examples
		doexe ode/test/*.exe
		doexe drawstuff/dstest/dstest.exe
		insinto /usr/share/${P}/examples
		doins ode/test/*.c ode/test/*.cpp
		doins drawstuff/textures/*.ppm
		doins drawstuff/dstest/dstest.cpp
	fi
}
