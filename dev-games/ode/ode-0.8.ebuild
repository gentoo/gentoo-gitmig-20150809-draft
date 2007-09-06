# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.8.ebuild,v 1.9 2007/09/06 07:30:39 opfer Exp $

inherit eutils autotools

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${PN}-src-${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="double-precision examples nogyroscopic noopcode"

RDEPEND="examples? (
		virtual/opengl
		virtual/glu
		x11-libs/libXmu
		x11-libs/libXi
	)"
DEPEND="app-arch/unzip
	virtual/opengl
	virtual/glu
	x11-libs/libXmu
	x11-libs/libXi"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-flags.patch
	eautoreconf

	sed -i -e "s/..\/..\/drawstuff\/textures/\/usr\/share\/${PF}\/examples/" ode/test/*.c*
	sed -i -e "s/fn.path_to_textures = 0/fn.path_to_textures = \"\/usr\/share\/${PF}\/examples\"/" drawstuff/dstest/dstest.cpp
	sed -i -e "s/inline_[\t]*void[\t*]ResetCountDown/void ResetCountDown/" OPCODE/OPC_TreeCollider.h
}

src_compile() {
	econf \
		$(use_enable double-precision) \
		$(use_enable !noopcode opcode) \
		$(use_enable !nogyroscopic gyroscopic) \
		--enable-release \
		|| die

	emake || die "ODE compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
	dodoc CHANGELOG.txt README.txt
	# Install API docs
	dohtml docs/*

	if use examples; then
		# install examples
		dodir /usr/share/${PF}/examples
		exeinto /usr/share/${PF}/examples
		cd ode/test
		doexe test_basket test_boxstack test_buggy test_chain1 test_chain2 \
			test_collision test_crash test_cyl test_cylvssphere test_friction \
			test_hinge test_I test_joints test_motor test_moving_trimesh \
			test_ode test_slider test_space test_space_stress test_step \
			test_trimesh
		cd ../..
		doexe drawstuff/dstest/dstest
		insinto /usr/share/${PF}/examples
		doins ode/test/*.{c,cpp,h}
		doins drawstuff/textures/*.ppm
		doins drawstuff/dstest/dstest.cpp
		doins drawstuff/src/{drawstuff.cpp,internal.h,x11.cpp}
	fi
}
