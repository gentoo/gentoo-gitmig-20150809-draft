# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-5.04.3-r1.ebuild,v 1.2 2003/05/22 06:52:30 kosmikus Exp $

#Some explanation of bootstrap logic:
#
#After thinking through the best way to bootstrap ghc I decided to split it into
#ghc and ghc-bin and make ghc depend on ghc-bin.
#  The ebuild has been revamped and greatly simplified. Bootstrap off old 4x hc files no longer works on x86.
#Not sure what happens with old scheme on sparc, as I did not see any test reports.
#
#The considerations:
#Making ghc unpack binary build first (under ${WORKDIR}) and bootstrapping from that will effectively force
#ghc-bin reinstall every time ghc is rebuilt or upgraded. What is worse it will likely force download of binary image
#at upgrade, which is not nice (in fact quite bad for modem users - 16+ MB).
#
#The best results are achieved if ghc-bin is left alone after ghc installation -
#Both ebuilds install in the same place, thus space penalty is minimal. In fact only the docs exist in double
#(considering that ghc is not installing much docs at present this looks more like an advantage).
#When the upgrade time comes, if you still have ghc-bin around, portage will happily bootstrap off
#your existing ghc (or ghc-bin, whichever was merged last), without attempting to ruin anything...
#
#There is only one issue: ghci will be successfully built only if ghc is bootstrapped from the same version.
#Thus we need to detect presently installed one and bootstrap in one or two stages..

inherit base

IUSE="doc tetex opengl"

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

SRC_URI="http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc -ppc -alpha"


PROVIDE="virtual/ghc"
# FIXME: Add USE support for parallel haskell (requires PVM)
#        Get PVM from ftp://ftp.netlib.org/pvm3/
DEPEND="virtual/ghc
	>=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=sys-devel/make-3.79.1
	>=sys-apps/sed-3.02.80
	>=sys-devel/flex-2.5.4a
	>=dev-libs/gmp-4.1
	doc? ( >=app-text/openjade-1.3.1
		>=app-text/sgml-common-0.6.3
		=app-text/docbook-sgml-dtd-3.1-r1
		>=app-text/docbook-dsssl-stylesheets-1.64
		>=dev-haskell/haddock-0.4
		tetex? ( >=app-text/tetex-1.0.7
			>=app-text/jadetex-3.12 ) )	
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )"

RDEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.3
	>=dev-lang/perl-5.6.1
	opengl? ( virtual/opengl virtual/glu virtual/glut )"


#determine what version of ghc we have around:
if test -z "${GHC}"; then
	GHC=`which ghc`
fi

BASE_GHC_VERSION=`"$GHC" --version | sed 's/^.*version //'`

# If the base GHC version matches wanted one we can skip stage1
if test x${BASE_GHC_VERSION} = x${PV}; then
	need_stage1=no
else
	need_stage1=yes
fi

# If we update from certain package combinations, we need to compile
# twice to get a GHCi bug fixed ...
has_version '>=sys-libs/glibc-2.3.2' \
	&& has_version '<=virtual/ghc-5.04.3' \
	&& need_stage1=yes

# some vars
STAGE1_B="${WORKDIR}/stage1-build"
STAGE2_B="${WORKDIR}/stage2-build"
STAGE1_D="${BUILDDIR}/stage1-image"

# extend path to /opt/ghc/bin to guarantee that ghc-bin is found
GHCPATH="${PATH}:/opt/ghc/bin"

src_unpack() {
	base_src_unpack

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

	# apply patch to Linker.c to fix a problem with undefined symbols
	# when starting GHCi
	patch -p0 < ${FILESDIR}/ghc-5.04.3-r1.patch

	# Create build directories.
	if test x$need_stage1 = xyes; then
		echo '>>> Creating stage 1 build dir'
		mkdir ${STAGE1_B} || die
		${LNDIR} ${S} ${STAGE1_B} || die
	fi
	echo '>>> Creating stage 2 build dir'
	mkdir ${STAGE2_B} || die
	${LNDIR} ${S} ${STAGE2_B} || die

}

src_compile() {
	local myconf
	use opengl && myconf="--enable-hopengl" || myconf="--disable-hopengl"

	if test x$need_stage1 = xyes; then
		echo ">>> Bootstrapping intermediate GHC ${PV} using GHC ${BASE_GHC_VERSION}"

		pushd "${STAGE1_B}" || die
			PATH="${GHCPATH}" ./configure \
				-host="${CHOST}" \
				--prefix="${STAGE1_D}/usr" \
				--with-ghc="${GHC}" \
				--without-happy || die "intermediate stage configure failed"
			#parallel make causes trouble
			make || die "intermediate stage make failed"
			make install || die
			GHC=${STAGE1_D}/usr/bin/ghc
		popd
	fi

	pushd "${STAGE2_B}" || die
		# unset SGML_CATALOG_FILES because documentation installation
		# breaks otherwise ...
		PATH="${GHCPATH}" SGML_CATALOG_FILES="" econf \
			--enable-threaded-rts \
			--with-ghc="${GHC}" \
			${myconf}|| die "./configure failed"
		# the build does not seem to work all that
		# well with parallel make
		make || die

		# if documentation has been requested, build documentation ...
		if use doc; then
			emake html || die
			if use tetex; then
				emake ps || die
			fi
		fi
	popd

}

src_install () {
	local mydoc

	pushd "${STAGE2_B}" || die
		# determine what to do with documentation
		if [ `use doc` ]; then
			mydoc="html"
			if [ `use tetex` ]; then
				mydoc="${mydoc} ps"
			fi
		else
			mydoc=""
			# needed to prevent haddock from being called
			echo NO_HADDOCK_DOCS=YES >> mk/build.mk
		fi
		echo SGMLDocWays="${mydoc}" >> mk/build.mk

		make install install-docs \
			prefix="${D}/usr" \
			datadir="${D}/usr/share/doc/${PF}" \
			infodir="${D}/usr/share/info" \
			mandir="${D}/usr/share/man" || die
	popd

	#need to remove ${D} from ghcprof script
	cd ${D}/usr/bin
	mv ghcprof ghcprof-orig
	sed -e 's:$FPTOOLS_TOP_ABS:#$FPTOOLS_TOP_ABS:' ghcprof-orig > ghcprof
	chmod a+x ghcprof
	rm -f ghcprof-orig

	cd ${S}/ghc
	dodoc README ANNOUNCE LICENSE VERSION
}

pkg_postinst () {
	einfo "If you have dev-lang/ghc-bin installed, you might"
	einfo "want to unmerge it again. It is no longer needed."
}
