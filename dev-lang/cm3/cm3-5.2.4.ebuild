# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3/cm3-5.2.4.ebuild,v 1.2 2003/04/30 02:23:00 vapier Exp $

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
export PATH="${cm3base}/bin:${PATH}"
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
	dodir /usr/lib/cm3
	mv ${cm3base}/pkg ${D}/usr/lib/cm3/
	dobin ${FILESDIR}/m3{build,ship}
	dosym /usr/lib/cm3/pkg/cm3/${M3_TARGET}/cm3 /usr/bin/cm3
	into /usr/lib/cm3/
	dobin ${cm3base}/bin/cm3cg

	insinto /usr/bin
	echo "ROOT=\"/usr/lib/cm3/pkg/\"" >> ${cm3base}/bin/cm3.cfg
	doins ${cm3base}/bin/cm3.cfg

	for lib in `find ${D}/usr/lib/cm3/ -name 'libm3*.so*'` ; do
		lib=${lib:${#D}}
		dosym ${lib} /usr/lib/`basename ${lib}`
	done

	for f in `grep -lIR ${PORTAGE_TMPDIR}/portage/${PF} ${D}` ; do
		f=${f:${#D}}
		dosed "s:${cm3base}:/usr/lib/cm3/:" ${f}
		dosed "s:${S}/m3-libs:/usr/lib/cm3/pkg/:" ${f}
		dosed "s:${S}/m3-sys:/usr/lib/cm3/pkg/:" ${f}
	done
}
