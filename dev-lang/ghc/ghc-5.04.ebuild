# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-5.04.ebuild,v 1.9 2003/09/11 01:08:23 msterret Exp $

IUSE="opengl"


# ebuild for Glorious Glasgow Haskell
#
# The build takes as many as three stages:
#
# - Stage 1 (may not be required):
#   If no GHC is found installed, we bootstrap an old one from HC files
# - Stage 2 (may not be required):
#   If the (now) available GHC is of an earlier version than the one
#   we want, we build an extra intermediate one for bootstrapping the
#   final stage. This is necessary because GHCi will only build with
#   a matching version of GHC.
# - Stage 3:
#   The full and final GHC is built, including HOpenGL (if using
#   opengl), and GHCi.
#
# Set the GHC environment variable to your GHC executable if it's not
# in your PATH.
#
# USE variable summary:
#   opengl - Build HOpenGL (OpenGL binding for Haskell).
#
# 2002-05-22  Sven Moritz Hallberg <pesco@gmx.de>

inherit base


DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc "


# FIXME: Add USE support for parallel haskell (requires PVM)
#        Get PVM from ftp://ftp.netlib.org/pvm3/
DEPEND="virtual/glibc
		>=dev-lang/perl-5.6.1
		>=sys-devel/gcc-2.95.3
		>=sys-devel/make-3.79.1
		>=sys-apps/sed-3.02.80
		>=sys-devel/flex-2.5.4a
		>=dev-libs/gmp-4.1
		opengl? ( virtual/opengl
				virtual/glu
				virtual/glut )"

RDEPEND="virtual/glibc
		>=sys-devel/gcc-2.95.3
		>=dev-lang/perl-5.6.1
		opengl? ( virtual/opengl virtual/glu virtual/glut )"


# Settings for the individual stages...

STAGE1_PV="4.08.2"
STAGE1_S="${WORKDIR}/ghc-${STAGE1_PV}"
STAGE1_B="${WORKDIR}/stage1-build"
STAGE1_D="${BUILDDIR}/stage1-image"

# Stage 2 version is ${PV}
# Stage 2 source is in ${S}
STAGE2_B="${WORKDIR}/stage2-build"
STAGE2_D="${BUILDDIR}/stage2-image"

# Stage 3 version is ${PV}
# Stage 3 source is in ${S}
STAGE3_B="${WORKDIR}/stage3-build"
# Stage 3 destination is ${D}


# --- What to Build ---

# Try to find an already-running GHC.
if test -z "${GHC}"; then
	if which_ghc=`which ghc`; then
		GHC="${which_ghc}"
	fi
fi
# If none was found, we need to bootstrap from HC files.
if test -z "${GHC}"; then
	echo It seems you do not have any version of GHC available yet.
	echo I will bootstrap from HC files.
	boot_from_hc=yes

	# This is the version of our "base GHC", that is, the one we will use
	# for the first build from Haskell source. It's the stage 1's
	# version if there is no outside GHC, or that one's version
	# otherwise (see else clause below).
	BASE_GHC_VERSION=${STAGE1_PV}
else
	boot_from_hc=no
	BASE_GHC_VERSION=`"$GHC" --version | sed 's/^.*version //'`
fi


# If the base GHC already has the same version as the one we want
# to build, stage 2 can be skipped.
if test x${BASE_GHC_VERSION} = x${PV}; then
	need_stage2=no
else
	need_stage2=yes
fi


# Determine which source files to download:
#  - We always need the source distribution for the final version.
#  - If bootstrap from HC files is required:
#     - We need the corresponding source distribution.
#     - We need a set of HC files suitable for our architecture.

# List of platforms for which registerised HC files are available.
HC_PLATS="x86"

SRC_URI="http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-src.tar.bz2"
if test x$boot_from_hc = xyes; then
	SRC_URI="$SRC_URI http://www.haskell.org/ghc/dist/${STAGE1_PV}/ghc-${STAGE1_PV}-src.tar.bz2"

	# First pick out the ARCH variable from
	# /etc/make.profile/make.defaults .
	arch=`source /etc/make.profile/make.defaults; echo -n $ARCH`

	# Try to pick the correct set of HC files for our architecture.
	use_unreg=yes
	for i in $HC_PLATS; do
		if test x$arch = x$i; then
			SRC_URI="$SRC_URI http://www.haskell.org/ghc/dist/${STAGE1_PV}/ghc-${STAGE1_PV}-$i-hc.tar.bz2"
			use_unreg=no
			break
		fi
	done
	if test x$use_unreg = xyes; then
		SRC_URI="$SRC_URI http://www.haskell.org/ghc/dist/${STAGE1_PV}/ghc-${STAGE1_PV}-unreg-hc.tar.bz2"
	fi
fi


# --- Function Entry Points ---

src_unpack() {
	base_src_unpack

	if test x$boot_from_hc = xyes; then
		# Patch GHC 4's hc-build script to check for GNU Make's name.
		echo '>>> Patching stage 1 sources.'
		bzcat ${FILESDIR}/ghc-${STAGE1_PV}-gentoo.patch.bz2 | patch -d ${STAGE1_S} -p1 || die
	fi

	# Patch GHC 5's configure script to recognize --without-happy
	echo '>>> Patching stage 2/3 sources.'
	bzcat ${FILESDIR}/ghc-${PV}-gentoo.patch.bz2 | patch -d ${S} -p1 || die

	# Create our own lndir if none installed.
	local LNDIR
	if which lndir; then
		LNDIR=lndir
	else
		# Current directory should be $WORKDIR.
		echo "You don\'t seem to have lndir available, building my own"
		echo "version..."
		cp ${FILESDIR}/lndir.c . || die
		make lndir || die
		LNDIR=./lndir
	fi

	# Create build directories.
	if test x$boot_from_hc = xyes; then
		echo '>>> Creating stage 1 build dir'
		mkdir ${STAGE1_B} || die
		${LNDIR} ${STAGE1_S} ${STAGE1_B} || die
	fi
	if test x$need_stage2 = xyes; then
		echo '>>> Creating stage 2 build dir'
		mkdir ${STAGE2_B} || die
		${LNDIR} ${S} ${STAGE2_B} || die
	fi
	echo '>>> Creating stage 3 build dir'
	mkdir ${STAGE3_B} || die
	${LNDIR} ${S} ${STAGE3_B} || die
}

src_compile() {
	if test x$boot_from_hc = xyes; then
		echo ">>> Bootstrapping GHC ${STAGE1_PV} from HC files"
		build_stage1        # bootstrap from HC files
	fi
	if test x$need_stage2 = xyes; then
		echo ">>> Bootstrapping intermediate GHC ${PV} using GHC ${BASE_GHC_VERSION}"
		build_stage2        # bootstrap intermediate GHC
	fi
	echo ">>> Building complete GHC ${PV} using GHC ${PV} itself"
	build_stage3            # final build
}

src_install() {
	pushd ${STAGE3_B} || die
		make install \
				prefix="${D}/usr" \
				infodir="${D}/usr/share/info" \
				mandir="${D}/usr/share/man" || die

		# Documentation
		pushd ghc || die

			# Misc
			dodoc README ANNOUNCE LICENSE || die

		# End documentation
		popd
	popd
}


# --- Build Stages ---

build_stage1() {
	pushd "${STAGE1_B}" || die

		GMAKE=make distrib/hc-build \
				--prefix="${STAGE1_D}/usr" \
				--host="${CHOST}" || die
		make install || die
		GHC=${STAGE1_D}/usr/bin/ghc

	popd
}

build_stage2() {
	pushd "${STAGE2_B}" || die

		./configure \
				--host="${CHOST}" \
				--prefix="${STAGE2_D}/usr" \
				--with-ghc="${GHC}" \
				--without-happy || die
		# I experienced strange failures during the make process when
		# using emake (which sets -j 2 in my (default) config).
		# I hope this will fix that.
		make || die
		make install || die
		GHC=${STAGE2_D}/usr/bin/ghc

	popd
}

build_stage3() {
	pushd "${STAGE3_B}" || die

		local myconf
		use opengl && myconf="--enable-hopengl"
		./configure \
				--host="${CHOST}" \
				--prefix=/usr \
				--infodir=/usr/share/info \
				--mandir=/usr/share/man \
				--with-ghc="${GHC}" \
				--without-happy \
				${myconf} || die
		make || die

	popd
}
