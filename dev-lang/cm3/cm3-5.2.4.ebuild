# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3/cm3-5.2.4.ebuild,v 1.1 2003/04/17 16:10:51 vapier Exp $

M3_TARGET="LINUXLIBC6"
MY_P="${PN}-src-all-${PV}"
DESCRIPTION="Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="http://www.elegosoft.com/cm3/${MY_P}.tgz
	http://www.elegosoft.com/cm3/cm3-min-POSIX-${M3_TARGET}-${PV}.tgz"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcltk"

DEPEND="tcltk? ( dev-lang/tcl )
	sys-devel/gcc"

S=${WORKDIR}

export cm3base=${T}/cm3base/
export PATH="${PATH}:${cm3base}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH} ${cm3base}/lib"

src_unpack() {
	unpack ${A}

	mkdir ${cm3base}
	tar -zxf system.tgz -C ${cm3base} || die

	[ -z "${EDITOR}" ] && export EDITOR=/usr/bin/nano
	[ -z "${CC}" ] && export CC=gcc
	[ -z "${CFLAGS}" ] && export CFLAGS="-O"
	[ -z "${MAKE}" ] && export MAKE=make
	sed -e "s:GENTOO_INITIAL_REACTOR_EDITOR:${EDITOR}:" \
		-e "s:GENTOO_INSTALL_ROOT:${cm3base}:" \
		-e "s:GENTOO_GNU_CC:${CC}:" \
		-e "s:GENTOO_GNU_CFLAGS:${CFLAGS}:" \
		-e "s:GENTOO_GNU_MAKE:${MAKE}:" \
		${FILESDIR}/cm3.cfg > ${cm3base}/bin/cm3.cfg
}

src_compile() {
	# we have to set ROOT/P ... they mess up the build scripts
	# if we dont :/
	export GCC_BACKEND="yes"
	export M3GDB="no"
	unset M3GC_SIMPLE
	export HAVE_SERIAL="no"
	use tcltk \
		&& HAVE_TCL="yes" \
		|| HAVE_TCL="no"

	export TMPDIR=${T}
	cd scripts
	for s in do-cm3-core boot-cm3-with-m3 do-cm3-base ; do
		env -u P ROOT=${S} ./${s}.sh build || die "failed on ${s}"
		env -u P ROOT=${S} ./${s}.sh ship || die "failed on ${s}"
	done
}

src_install() {
	# i know this is wrong but hey, thats why this is in package.mask ;)
	for d in ${cm3base}/pkg/* ; do
		rm -rf ${d}/src/*
		mv ${d}/${M3_TARGET}/* ${d}/
	done
	dodir /usr/lib/cm3
	mv ${cm3base}/pkg ${D}/usr/lib/cm3/
}
