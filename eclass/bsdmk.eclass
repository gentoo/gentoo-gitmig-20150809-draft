# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bsdmk.eclass,v 1.1 2006/04/01 15:24:18 flameeyes Exp $
#
# Otavio R. Piske "AngusYoung" <angusyoung@gentoo.org>
# Diego Pettenò <flameeyes@gentoo.org>
# Benigno B. Junior <bbj@gentoo.org>

inherit toolchain-funcs portability

EXPORT_FUNCTIONS src_compile src_install

# this should actually be BDEPEND, but this works.
DEPEND="!userland_BSD? ( sys-devel/pmake )"

#### append-opt <options>
# append options to enable or disable features
#
###########################################################################
append-opt() {
	mymakeopts="${mymakeopts} $@"
}

#### mkmake <options>
# calls bsd-make command with the given options, passing ${mymakeopts} to
# enable ports to useflags bridge.
#
###########################################################################
mkmake() {
	[[ -z ${BMAKE} ]] && BMAKE="$(get_bmake)"

	tc-export CC CXX LD RANLIB

	${BMAKE} ${MAKEOPTS} ${EXTRA_EMAKE} ${mymakeopts} NO_WERROR= "$@"
}

mkinstall() {
	[[ -z ${BMAKE} ]] && BMAKE="$(get_bmake)"

	${BMAKE} ${mymakeopts} NO_WERROR= DESTDIR="${D}" "$@" install
}

#### dummy_mk <dirnames>
# removes the specified subdirectories and creates a dummy makefile in them
# useful to remove the need for "minimal" patches
#
############################################################################
dummy_mk() {
	for dir in $@; do
		echo ".include <bsd.lib.mk>" > ${dir}/Makefile
	done
}

#### fix_lazy_bindings <dirnames>
# set LDFLAGS in order to fix lazy binding warnings in binaries
#
############################################################################
fix_lazy_bindings() {
	for dir in $@; do
		echo "LDFLAGS+= -Wl,-z,now" >> ${dir}/Makefile
	done
}

bsdmk_src_compile() {
	cd ${S}
	mkmake || die "make failed"
}

bsdmk_src_install() {
	cd ${S}
	mkinstall || die "install failed"
}
