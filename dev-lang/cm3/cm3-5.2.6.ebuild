# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3/cm3-5.2.6.ebuild,v 1.3 2003/07/17 20:00:47 vapier Exp $

DESCRIPTION="Critical Mass Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="http://www.elegosoft.com/cm3/${PN}-src-all-${PV}.tgz"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="tcltk"

DEPEND="tcltk? ( dev-lang/tcl )
	sys-devel/gcc
	dev-lang/cm3-bin"

S=${WORKDIR}

export GCC_BACKEND="yes"
export M3GDB="no"
export HAVE_SERIAL="no"
unset M3GC_SIMPLE
[ `use tcltk` ] \
	&& HAVE_TCL="yes" \
	|| HAVE_TCL="no"

src_compile() {
	cd scripts
	for s in do-cm3-core do-cm3-base ; do
		env -u P ROOT=${S} ./${s}.sh build || die "building ${s}"
	done
}

src_install() {
	local TARGET=`grep 'TARGET.*=' /usr/bin/cm3.cfg | awk '{print $4}' | sed 's:"::g'`
	sed -i "s:\"/usr/lib/cm3/:\"${D}/usr/lib/cm3/:g" `find -name .M3SHIP` || die "fixing .M3SHIP"

	cd scripts
	dodir /usr/lib/cm3
	for s in do-cm3-core do-cm3-base ; do
		env -u P ROOT=${S} ./${s}.sh ship || die "shipping ${s}"
	done
	cd ${D}/usr/lib/cm3/pkg
	sed -i "s:${S}/*[^/-]*-[^/\"]*:/usr/lib/cm3/pkg:" `grep -RIl /var/tmp/portage *` || die "fixing .M3EXPORTS"

	# do all this crazy linking so as to overwrite cm3-bin stuff
	dodir /usr/bin
	insinto /usr/lib/cm3/bin
	doins /usr/bin/cm3.cfg
	dosym /usr/lib/cm3/pkg/cm3/${TARGET}/cm3 /usr/lib/cm3/bin/cm3
	dosym /usr/lib/cm3/bin/cm3 /usr/bin/cm3
	dosym /usr/lib/cm3/bin/cm3cg /usr/bin/cm3cg
	dosym /usr/lib/cm3/bin/cm3.cfg /usr/bin/cm3.cfg
	dobin ${FILESDIR}/m3{build,ship}

	insinto /etc/env.d
	doins ${FILESDIR}/05cm3
}
