# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx/nx-3.5.0-r1.ebuild,v 1.3 2011/10/08 16:16:14 phajdan.jr Exp $

EAPI=4
inherit autotools eutils multilib

DESCRIPTION="NX compression technology core libraries"
HOMEPAGE="http://www.nomachine.com/developers.php"

URI_BASE="http://web04.nomachine.com/download/${PV}/sources"
SRC_NX_X11="nx-X11-$PV-2.tar.gz"
SRC_NXAGENT="nxagent-$PV-5.tar.gz"
SRC_NXAUTH="nxauth-$PV-1.tar.gz"
SRC_NXCOMP="nxcomp-$PV-2.tar.gz"
SRC_NXCOMPEXT="nxcompext-$PV-1.tar.gz"
SRC_NXCOMPSHAD="nxcompshad-$PV-2.tar.gz"
SRC_NXPROXY="nxproxy-$PV-1.tar.gz"

SRC_URI="$URI_BASE/$SRC_NX_X11 $URI_BASE/$SRC_NXAGENT $URI_BASE/$SRC_NXPROXY $URI_BASE/$SRC_NXAUTH $URI_BASE/$SRC_NXCOMPEXT $URI_BASE/$SRC_NXCOMPSHAD $URI_BASE/$SRC_NXCOMP"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="elibc_glibc"

RDEPEND="elibc_glibc? ( || ( net-libs/libtirpc <sys-libs/glibc-2.14 ) )
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXtst
	>=media-libs/libpng-1.2.8
	>=sys-libs/zlib-1.2.3
	virtual/jpeg"

DEPEND="${RDEPEND}
		x11-misc/gccmakedep
		x11-misc/imake
		x11-proto/inputproto"

S=${WORKDIR}/${PN}-X11

src_prepare() {
	# For nxcl/qtnx
	cd "${WORKDIR}"/nxproxy
	epatch "${FILESDIR}"/${PN}-3.2.0-nxproxy_read_from_stdin.patch

	# libpn-1.5 support
	cd "${WORKDIR}"/nxcomp
	epatch "${FILESDIR}"/${P}-libpng15.patch

	cd "${WORKDIR}"
	# Fix sandbox violation
	epatch "${FILESDIR}"/1.5.0/nx-x11-1.5.0-tmp-exec.patch
	# -fPIC
	epatch "${FILESDIR}"/1.5.0/nxcomp-1.5.0-pic.patch
	# Respect CFLAGS/CXXFLAGS
	epatch "${FILESDIR}"/${PN}-3.3.0-cflags.patch
	# Run autoreconf in all neeed folders
	for i in nxcomp nxcompext nxcompshad nxproxy; do
		cd "${WORKDIR}"/${i}
		eautoreconf ${i}
		cd "${WORKDIR}"
	done

	# From xorg-x11-6.9.0-r3.ebuild
	cd "${S}"
	HOSTCONF="config/cf/host.def"
	echo "#define CcCmd $(tc-getCC)" >> ${HOSTCONF}
	echo "#define OptimizedCDebugFlags ${CFLAGS} GccAliasingArgs" >> ${HOSTCONF}
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} GccAliasingArgs" >> ${HOSTCONF}
	# Respect LDFLAGS
	echo "#define ExtraLoadFlags ${LDFLAGS}" >> ${HOSTCONF}
	echo "#define SharedLibraryLoadFlags -shared ${LDFLAGS}" >> ${HOSTCONF}
	echo "#define BuildXInputLib YES" >> ${HOSTCONF}
}

src_configure() {
	for i in nxcomp nxcompshad nxproxy nxcompext ; do
		cd "${WORKDIR}"/${i}
		econf
	done
}

src_compile() {
	for i in nxcomp nxcompshad nxproxy; do
		cd "${WORKDIR}"/${i}
		emake
	done

	cd "${S}"
	# Again, from xorg-x11-6.9.0-r3.ebuild
	unset MAKE_OPTS
	FAST=1 emake -j1 World WORLDOPTS="" MAKE="make"

	cd "${WORKDIR}"/nxcompext
	emake
}

src_install() {
	NX_ROOT=/usr/$(get_libdir)/NX

	for x in nxagent nxauth nxproxy; do
		make_wrapper $x ./$x ${NX_ROOT}/bin ${NX_ROOT}/$(get_libdir) ||
			die " $x wrapper creation failed"
	done

	into ${NX_ROOT}
	dobin "${S}"/programs/Xserver/nxagent
	dobin "${S}"/programs/nxauth/nxauth
	dobin "${WORKDIR}"/nxproxy/nxproxy

	dolib.so "${S}"/lib/X11/libX11.so*
	dolib.so "${S}"/lib/Xext/libXext.so*
	dolib.so "${S}"/lib/Xi/libXi.so*
	dolib.so "${S}"/lib/Xrender/libXrender.so*
	dolib.so "${WORKDIR}"/nxcomp/libXcomp.so*
	dolib.so "${WORKDIR}"/nxcompext/libXcompext.so*
	dolib.so "${WORKDIR}"/nxcompshad/libXcompshad.so*
}
