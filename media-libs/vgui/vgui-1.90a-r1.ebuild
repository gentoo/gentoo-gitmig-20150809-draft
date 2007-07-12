# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vgui/vgui-1.90a-r1.ebuild,v 1.2 2007/07/12 03:10:24 mr_bones_ Exp $

MY_PN="v"
MY_PV="${PV/a}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="V is a free portable C++ GUI Framework"
HOMEPAGE="http://vgui.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
		 mirror://sourceforge/${PN}/${MY_PN}-${PV}-patch.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="|| ( ( media-libs/glut
				x11-libs/libXaw
				virtual/opengl
				virtual/glut )
			virtual/x11 )
		virtual/libc"
DEPEND="${RDEPEND}
	|| ( ( 	x11-proto/xextproto
			x11-proto/xproto )
		virtual/x11 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	unpack ${MY_PN}-${PV}-patch.tar.gz
	# renames ./home/vgui to ${S}
	mv ${WORKDIR}/home/vgui ${S}
	# put ./home/help inside ${S}
	mv ${WORKDIR}/home/help ${S}

	cd ${S}

	for i in srcx/vtimer.cxx includex/v/vtimer.h; do
		sed -e 's|notUsed|notUsedVariable|g' -i ${i}
	done
}

src_compile() {
	local sedexp

	# OpenGL support is broken upstream :-(
	#if use opengl; then
	#	sedexp="s|^NeedGLw.*|NeedGLw = no|"
	#else
		sedexp="s|^NeedGLw.*|NeedGLw = yes|"
	#fi

	sedexp="${sedexp};s|^ARCH.*|ARCH = linuxelf|"
	sedexp="${sedexp};s|^HOMEV.*|HOMEV = ${S}|"

	# Motif support is broken upstream
	#if use motif; then
	#	sedexp="${sedexp};s|^TOOLKIT.*|TOOLKIT = Motif|"
	#else
		sedexp="${sedexp};s|^TOOLKIT.*|TOOLKIT = Athena|"
	#fi

	# set up config stuff
	sed -e "${sedexp}" -i Config.mk

	# cflag borkage
	local oldcflags="${CFLAGS}"
	export CFLAGS=""
	echo "CFLAGS += ${oldcflags}" >> Config.mk

	emake vlib || die
	emake vtest utils examples || die
	emake || die
}

src_install() {
	insinto /usr/include/v
	doins includex/v/*
	rm bin/ThisIs
	dobin bin/*
	dolib.so lib/libVx.so.${MY_PV} lib/libVxgl.so.${MY_PV}

	local docs=/usr/share/doc/${PF}/html
	dodir ${docs}
	mv help/vrefman/ ${D}${docs}
}
