# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.3.ebuild,v 1.1 2007/08/20 17:58:51 caster Exp $

inherit eutils java-pkg-2 java-ant-2 toolchain-funcs

#MY_PV="${PV/_rc/RC}"
MY_PV="${PV}"
MY_DMF="R-${MY_PV}-200706251500"
MY_P="${PN}-${MY_PV}"
# https://overlays.gentoo.org/svn/proj/java/other/swt-patches
#PATCHSET="${P}-gentoo-patches-r1"
DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? (
			http://download.eclipse.org/downloads/drops/${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		x86-fbsd? (
			http://download.eclipse.org/downloads/drops/${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		amd64? (
			http://download.eclipse.org/downloads/drops/${MY_DMF}/${MY_P}-gtk-linux-x86_64.zip
		)
		ppc? (
			http://download.eclipse.org/downloads/drops/${MY_DMF}/${MY_P}-gtk-linux-ppc.zip
		)"
#		mirror://gentoo/${PATCHSET}.tar.bz2"

SLOT="3"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE="cairo firefox gnome seamonkey opengl xulrunner"
COMMON=">=dev-libs/glib-2.6
		>=x11-libs/gtk+-2.6.8
		>=dev-libs/atk-1.10.2
		cairo? ( >=x11-libs/cairo-1.0.2 )
		gnome?	(
					=gnome-base/libgnome-2*
					=gnome-base/gnome-vfs-2*
					=gnome-base/libgnomeui-2*
				)
		seamonkey? ( !firefox? ( !xulrunner? (
			>=www-client/seamonkey-1.0.2
			>=dev-libs/nspr-4.6.2
		) ) )
		firefox? ( !xulrunner? (
			>=www-client/mozilla-firefox-2
			>=dev-libs/nspr-4.6.2
		) )
		xulrunner? (
			net-libs/xulrunner
			>=dev-libs/nspr-4.6.2
		)
		opengl?	(
			virtual/opengl
			virtual/glu
		)"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXt
		x11-proto/xextproto
		${COMMON}"

# java-config for the env_var stuff, until it's stabled and forced by eclass
RDEPEND=">=virtual/jre-1.4
		x11-libs/libXtst
		>=dev-java/java-config-2.0.33
		${COMMON}"

S="${WORKDIR}"

src_unpack() {
	# determine the right file to unpack from $A
#	local DISTFILE=${A/${PATCHSET}.tar.bz2/}
	# just in case patchset is ordered before distfile
#	DISTFILE=${DISTFILE## }
	local DISTFILE="${A}"
	unzip -jq "${DISTDIR}"/${DISTFILE} "*src.zip" || die "unable to extract distfile"
	unpack ./src.zip

#	unpack "${PATCHSET}.tar.bz2"

	# Cleanup the redirtied directory structure
	rm -rf about_files/ || die

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp "${FILESDIR}"/build.xml ${S}/build.xml || die "Unable to update build.xml"
	mkdir ${S}/src && mv ${S}/org ${S}/src || die "Unable to restructure SWT sources"

	# apply all the patches, including arch-specific
#	EPATCH_SOURCE="${WORKDIR}/${PATCHSET}" EPATCH_SUFFIX="patch" epatch

	sed -i "s/CFLAGS = -O -Wall/CFLAGS = ${CFLAGS} -Wall/" \
		make_linux.mak \
		|| die "Failed to tweak make_linux.mak"

	sed -i "s/MOZILLACFLAGS = -O/MOZILLACFLAGS = ${CXXFLAGS}/" \
		make_linux.mak \
		|| die "Failed to tweak make_linux.mak"

	# kill some strict-aliasing warnings
	epatch "${FILESDIR}/${P}-callback-pointer-dereferencing.patch"
}

get_gecko() {
	local gecko

	# order here match the logic in DEPEND and USE flag descriptions
	use seamonkey && gecko="seamonkey"
	use firefox && gecko="firefox"
	use xulrunner && gecko="xulrunner"

	echo ${gecko}
}

src_compile() {
	# Drop jikes support as it seems to be unfriendly with SWT
	java-pkg_filter-compiler jikes

	# Identify the AWT path
	# The IBM VMs and the GNU GCC implementations do not store the AWT libraries
	# in the same location as the rest of the binary VMs.
	if [[ ! -z "$(java-config --java-version | grep 'IBM')" ]] ; then
		export AWT_LIB_PATH=$JAVA_HOME/jre/bin
	elif [[ ! -z "$(java-config --java-version | grep 'GNU libgcj')" ]] ; then
		export AWT_LIB_PATH=$JAVA_HOME/$(get_libdir)
	else
		if [[ $(tc-arch) == 'x86' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/i386
		elif [[ $(tc-arch) == 'ppc' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/ppc
		else
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/amd64
		fi
	fi

	# Fix the pointer size for AMD64
	[[ ${ARCH} == 'amd64' ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	local platform="linux"

	use elibc_FreeBSD && platform="freebsd"

	local make="emake -f make_${platform}.mak NO_STRIP=y"

	einfo "Building AWT library"
	${make} make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	${make} make_swt || die "Failed to build SWT support"

	einfo "Building JAVA-AT-SPI bridge"
	${make} make_atk || die "Failed to build ATK support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		${make} make_gnome || die "Failed to build GNOME VFS support"
	fi

	local gecko="$(get_gecko)"
	if [[ ${gecko} ]]; then
		einfo "Building the Mozilla component against ${gecko}"
		#local idir="$(pkg-config ${gecko}-xpcom --variable=includedir)"
		local inc="$(pkg-config ${gecko}-xpcom --cflags)"
		local libs="$(pkg-config ${gecko}-xpcom --libs)"
		MOZILLA_INCLUDES="${inc}" \
		MOZILLA_LIBS="${libs}" \
			${make} make_mozilla || die "Failed to build ${gecko} support"
		if [[ "${gecko}" = "xulrunner" ]]; then
			XULRUNNER_INCLUDES="${inc}" \
			XULRUNNER_LIBS="${libs}" \
				${make} make_xulrunner || die "Failed to build ${gecko} support"
		fi
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		${make} make_cairo || die "Unable to build CAIRO support"
	fi

	if use opengl ; then
		einfo "Building OpenGL component"
		${make} make_glx || die "Unable to build OpenGL component"
	fi

	einfo "Building JNI libraries"
	eant compile

	einfo "Copying missing files"
	cp -i "${S}/version.txt" "${S}/build/version.txt"
	cp -i "${S}/src/org/eclipse/swt/internal/SWTMessages.properties" \
		"${S}/build/org/eclipse/swt/internal/"

	einfo "Packing JNI libraries"
	eant jar
}

src_install() {
	java-pkg_dojar swt.jar

	java-pkg_sointo /usr/$(get_libdir)
	java-pkg_doso *.so

	local gecko="$(get_gecko)"
	if [[ -n "${gecko}" ]]; then
		local gecko_dir="$(pkg-config ${gecko}-xpcom --variable=libdir)"
		java-pkg_register-environment-variable MOZILLA_FIVE_HOME "${gecko_dir}"
	fi

	dohtml about.html || die
}

