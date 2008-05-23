# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openinventor/openinventor-2.1.5.10-r2.ebuild,v 1.7 2008/05/23 16:32:55 maekke Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 3 '-')
MY_PN="inventor"

DESCRIPTION="SGI OpenInventor Toolkit and Utilities"
HOMEPAGE="http://oss.sgi.com/projects/inventor/"
SRC_URI="ftp://oss.sgi.com/projects/${MY_PN}/download/${MY_PN}-${MY_PV}.src.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

RDEPEND="media-libs/mesa
	virtual/motif
	>=media-libs/jpeg-6b
	>=media-libs/freetype-2.0"
DEPEND="dev-util/byacc
	${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	if ! built_with_use media-libs/mesa motif; then
		echo
		eerror "In order to compile openinventor, you need to have media-libs/mesa emerged"
		eerror "with 'motif' in your USE flags. Please add that flag, re-emerge"
		eerror "media-libs/mesa, and then emerge openinventor"
		die "media-libs/mesa is missing motif"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# ordinary yacc fails
	epatch "${FILESDIR}"/use-byacc.patch
	# support for amd64, sparc and alpha
	epatch "${FILESDIR}"/support-archs.patch
	# freetype2 wasn't enabled by default
	epatch "${FILESDIR}"/freetype2-activate.patch
	# extra #include statement necessary for freetype2
	epatch "${FILESDIR}"/freetype2-includes.patch
	# script aiding in manual installation required csh
	epatch "${FILESDIR}"/no-csh.patch
	# put files in sane places
	epatch "${FILESDIR}"/gentoo-paths-v2.patch
	# fix compilation with gcc-4
	epatch "${FILESDIR}"/gcc4-support.patch
}

src_compile() {
	# VLDOPTS: find libraries during linking of executables
	# VLDDSOOPTS: find libraries during linking of libraries
	# VCFLAGS / VCXXFLAGS: pass user-chosen compiler flags
	# OPTIMIZER: do not override user-chosen compiler flags
	# system
	emake \
		VLDOPTS="-L${S}/lib -L${S}/libSoXt" \
		VLDDSOOPTS="-L${S}/lib -L${S}/libSoXt" \
		VCFLAGS="${CFLAGS}" VCXXFLAGS="${CXXFLAGS}" \
		OPTIMIZER= \
		|| die "Build failed"

	# fix RUNME-scripts in the demos directory for new paths
	sed -i \
		-e 's:/usr/share/:/usr/share/openinventor/:g' \
		-e 's:/usr/demos/:/usr/share/openinventor/demos/:g' \
		$(find apps/demos -name *.RUNME)
}

src_install() {
	# IVROOT: serves as DESTDIR
	# LLDOPTS: delete, so it won't go linking with libraries already on the
	# system
	# IVLIBDIR: multilib-strict compliance
	# LD_LIBRARY_PATH: support executables ran during install
	make \
		IVROOT="${D}" \
		LLDOPTS= \
		IVLIBDIR="${D}usr/$(get_libdir)" \
		LD_LIBRARY_PATH="${D}usr/$(get_libdir)" \
		install \
		|| die "Install failed"

	# OpenInventor aliases for TrueType fonts
	local FONTDIR=/usr/share/fonts/corefonts
	local ALIASDIR=/usr/share/${PN}/fonts
	dodir ${ALIASDIR}
	dosym ${FONTDIR}/times.ttf ${ALIASDIR}/Times-Roman
	dosym ${FONTDIR}/arial.ttf ${ALIASDIR}/Helvetica
	dosym ${FONTDIR}/cour.ttf ${ALIASDIR}/Utopia-Regular
}
