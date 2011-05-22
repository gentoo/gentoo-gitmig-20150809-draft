# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx/nx-3.5.0.ebuild,v 1.1 2011/05/22 14:33:10 voyageur Exp $

EAPI=2
inherit autotools eutils multilib

DESCRIPTION="NX compression technology core libraries"
HOMEPAGE="http://www.nomachine.com/developers.php"

URI_BASE="http://web04.nomachine.com/download/${PV}/sources"
SRC_NX_X11="nx-X11-$PV-1.tar.gz"
SRC_NXAGENT="nxagent-$PV-2.tar.gz"
SRC_NXAUTH="nxauth-$PV-1.tar.gz"
SRC_NXCOMP="nxcomp-$PV-1.tar.gz"
SRC_NXCOMPEXT="nxcompext-$PV-1.tar.gz"
SRC_NXCOMPSHAD="nxcompshad-$PV-2.tar.gz"
SRC_NXPROXY="nxproxy-$PV-1.tar.gz"

SRC_URI="$URI_BASE/$SRC_NX_X11 $URI_BASE/$SRC_NXAGENT $URI_BASE/$SRC_NXPROXY $URI_BASE/$SRC_NXAUTH $URI_BASE/$SRC_NXCOMPEXT $URI_BASE/$SRC_NXCOMPSHAD $URI_BASE/$SRC_NXCOMP"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXau
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
}

src_configure() {
	cd "${WORKDIR}"/nxcomp || die "No nxcomp directory found"
	econf || die "nxcomp econf failed"

	cd "${WORKDIR}"/nxcompshad || die "No nxcompshad directory found"
	econf || die "nxcompshad econf failed"

	cd "${WORKDIR}"/nxproxy || die "No nxproxy directory found"
	econf || die "nxproxy econf failed"

	cd "${WORKDIR}"/nxcompext || die "No nxcompext directory found"
	econf || die "nxcompext econf failed"
}

src_compile() {
	cd "${WORKDIR}"/nxcomp || die "No nxcomp directory found"
	emake || die "nxcomp emake failed"

	cd "${WORKDIR}"/nxcompshad || die "No nxcompshad directory found"
	emake || die "nxcompshad emake failed"

	cd "${WORKDIR}"/nxproxy || die "No nxproxy directory found"
	emake || die "nxproxy emake failed"

	cd "${S}" || die "No nx-X11 directory found"
	# Again, from xorg-x11-6.9.0-r3.ebuild
	unset MAKE_OPTS
	FAST=1 emake -j1 World WORLDOPTS="" MAKE="make" || die "nx-X11 emake failed"

	cd "${WORKDIR}"/nxcompext || die "No nxcompext directory found"
	emake || die "nxcompext emake failed"
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
	dolib.so "${S}"/lib/Xrender/libXrender.so*
	dolib.so "${WORKDIR}"/nxcomp/libXcomp.so*
	dolib.so "${WORKDIR}"/nxcompext/libXcompext.so*
	dolib.so "${WORKDIR}"/nxcompshad/libXcompshad.so*
}
