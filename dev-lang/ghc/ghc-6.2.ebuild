# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.2.ebuild,v 1.4 2004/02/20 13:10:56 kosmikus Exp $

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
KEYWORDS="~x86 -ppc -alpha"


PROVIDE="virtual/ghc"
# FIXME: Add USE support for parallel haskell (requires PVM)
#	 Get PVM from ftp://ftp.netlib.org/pvm3/
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
		>=dev-haskell/haddock-0.6-r2
		tetex? ( >=app-text/tetex-1.0.7
			>=app-text/jadetex-3.12 ) )
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )"

RDEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.3
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	opengl? ( virtual/opengl virtual/glu virtual/glut )"

# extend path to /opt/ghc/bin to guarantee that ghc-bin is found
GHCPATH="${PATH}:/opt/ghc/bin"

src_unpack() {
	base_src_unpack

	# for documentation generation the new ghc should be used,
	# not the old one ...
	patch -p0 < ${FILESDIR}/ghc-6.2.documentation.patch
}

src_compile() {
	local myconf
	if [ `use opengl` ]; then
		myconf="--enable-hopengl"
	fi

	# disable the automatic PIC building which is considered as Prologue Junk by the Haskell Compiler
	# thanks to Peter Simons for finding this and giving notice on bugs.gentoo.org
	if has_version "sys-devel/hardened-gcc"
	then
		echo "SRC_CC_OPTS+=-yet_exec -yno_propolice" >> mk/build.mk
		echo "SRC_HC_OPTS+=-optc-yet_exec -optc-yno_propolice" >> mk/build.mk
		echo "SRC_CC_OPTS+=-yet_exec -yno_propolice" >> mk/build.mk
		echo "SRC_HC_OPTS+=-optc-yet_exec -optc-yno_propolice" >> mk/build.mk
	fi

	# force the config variable ArSupportsInput to be unset;
	# ar in binutils >= 2.14.90.0.8-r1 seems to be classified
	# incorrectly by the configure script
	echo "ArSupportsInput:=" >> mk/build.mk

	# unset SGML_CATALOG_FILES because documentation installation
	# breaks otherwise ...
	PATH="${GHCPATH}" SGML_CATALOG_FILES="" econf \
		--enable-threaded-rts ${myconf} || die "econf failed"

	# the build does not seem to work all that
	# well with parallel make
	make || die "make failed"

	# if documentation has been requested, build documentation ...
	if use doc; then
		make html || die "make html failed"
		if use tetex; then
			make ps || die "make ps failed"
		fi
	fi

}

src_install () {
	local mydoc
	local insttarget

	insttarget="install"

	# determine what to do with documentation
	if [ `use doc` ]; then
		mydoc="html"
		insttarget="${insttarget} install-docs"
		if [ `use tetex` ]; then
			mydoc="${mydoc} ps"
		fi
	else
		mydoc=""
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi
	echo SGMLDocWays="${mydoc}" >> mk/build.mk

	make ${insttarget} \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/doc/${PF}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" || die

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
