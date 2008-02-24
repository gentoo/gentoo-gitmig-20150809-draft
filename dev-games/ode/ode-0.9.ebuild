# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.9.ebuild,v 1.2 2008/02/24 09:45:27 vapier Exp $

inherit eutils autotools

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${PN}-src-${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
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
	epatch "${FILESDIR}"/${P}-x-flags.patch
	eautoreconf

	sed -i \
		-e "s:../../drawstuff/textures:/usr/share/${PF}/examples:" \
		ode/demo/*.c* \
		|| die "sed failed"
	sed -i \
		-e "s/fn.path_to_textures = 0/fn.path_to_textures = \"\/usr\/share\/${PF}\/examples\"/" \
		drawstuff/dstest/dstest.cpp \
		|| die "sed failed"
	sed -i \
		-e "s/inline_[\t]*void[\t*]ResetCountDown/void ResetCountDown/" \
		OPCODE/OPC_TreeCollider.h \
		|| die "sed failed"
	sed -i \
		-e '/USE_SONAME_TRUE/s:\(\$(libdir)\):$(DESTDIR)\1:' \
		-e '/USE_SONAME_TRUE.*ldconfig/d' \
		-e '/USE_SONAME_TRUE.*ln -s/s:\$(DESTDIR)::' \
		Makefile.in \
		|| die "sed failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable double-precision) \
		$(use_enable !noopcode opcode) \
		$(use_enable !nogyroscopic gyroscopic) \
		--enable-soname \
		--enable-release \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
	dodoc CHANGELOG.txt README.txt
	# Install API docs
	dohtml docs/*

	if use examples; then
		# install examples
		exeinto /usr/share/${PF}/examples
		cd ode/demo
		doexe demo_I demo_basket demo_boxstack demo_buggy \
			demo_chain1 demo_chain2 demo_collision demo_convex_cd \
			demo_crash demo_cyl demo_cylvssphere demo_feedback \
			demo_friction demo_heightfield demo_hinge demo_jointPR \
			demo_joints demo_motor demo_moving_trimesh demo_ode \
			demo_plane2d demo_slider demo_space demo_space_stress \
			demo_step demo_trimesh
		cd ../..
		doexe drawstuff/dstest/dstest
		insinto /usr/share/${PF}/examples
		doins ode/demo/*.{c,cpp,h} \
			drawstuff/textures/*.ppm \
			drawstuff/dstest/dstest.cpp \
			drawstuff/src/{drawstuff.cpp,internal.h,x11.cpp}
	fi
}
