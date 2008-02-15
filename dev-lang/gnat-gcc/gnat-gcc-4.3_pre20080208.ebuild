# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gcc/gnat-gcc-4.3_pre20080208.ebuild,v 1.1 2008/02/15 21:47:52 george Exp $

inherit versionator

# GCCVER should be set before inherit
Issue="$(get_version_component_range 3)"
GCCVER="$(get_version_component_range 1-2)-${Issue:3}"

inherit gnatbuild

DESCRIPTION="GNAT Ada Compiler - gcc version"
HOMEPAGE="http://gcc.gnu.org/"
LICENSE="GMGPL"

# overriding the BOOT_SLOT, as 4.1 should do fine, no need for bootstrap duplication
BOOT_SLOT="4.1"

# SLOT is set in gnatbuild.eclass, depends only on PV (basically SLOT=GCCBRANCH)
# so the URI's are static.
SRC_URI="ftp://gcc.gnu.org/pub/gcc/snapshots/${GCCVER}/gcc-core-${GCCVER}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/snapshots/${GCCVER}/gcc-ada-${GCCVER}.tar.bz2
	ppc?   ( mirror://gentoo/gnatboot-${BOOT_SLOT}-ppc.tar.bz2 )
	x86?   ( mirror://gentoo/gnatboot-${BOOT_SLOT}-i386.tar.bz2 )
	amd64? ( mirror://gentoo/gnatboot-${BOOT_SLOT}-amd64.tar.bz2 )"

KEYWORDS="~amd64 ~ppc ~x86"

QA_EXECSTACK="${BINPATH:1}/gnatls ${BINPATH:1}/gnatbind ${BINPATH:1}/gnatmake
	${LIBEXECPATH:1}/gnat1 ${LIBPATH:1}/adalib/libgnat-${SLOT}.so"

src_unpack() {
	gnatbuild_src_unpack

	#fixup some hardwired flags
	cd "${S}"/gcc/ada

	# universal gcc -> gnatgcc substitution occasionally produces lines too long
	# and then build halts on the style check.
	#
	# The sed in makegpr.adb is actually not for the line length but rather to
	# "undo" the fixing, Last3 is matching just that - the last three characters
	# of the compiler name.
	sed -i -e 's:(Last3 = "gnatgcc"):(Last3 = "gcc"):' makegpr.adb &&
	sed -i -e 's:and Nam is "gnatgcc":and Nam is "gcc":' osint.ads ||
		die	"reversing [gnat]gcc substitution in comments failed"

	# All snapshots seem to have a problem compiling with all the 
	# extra versioning declarations. Cleanup some vars..
	sed -i -e "/-DREVISION/d" -e "/-DDEVPHASE/d" \
		-e "s: -DDATESTAMP=\$(DATESTAMP_s)::" "${S}"/gcc/Makefile.in
#		-e "s:-DBUGURL=\$(BUGURL_s) ::" 
	sed -i -e "s: DATESTAMP DEVPHASE REVISION::" \
		-e "s:PKGVERSION:\"4.3.0\":" "${S}"/gcc/version.c
}

src_compile() {
	# looks like gnatlib_and_tools and gnatlib_shared have become part of
	# bootstrap
	gnatbuild_src_compile configure make-tools bootstrap
}


src_install() {
#	echo "contents of ${LIBEXECPATH}/gcc/${CTARGET}/${GCCRELEASE} :"
#	ls "${D}${LIBEXECPATH}/gcc/${CTARGET}/${GCCRELEASE}"
#	die
	GCCVER="4.3.0" GCCRELEASE="4.3.0" gnatbuild_src_install
}
