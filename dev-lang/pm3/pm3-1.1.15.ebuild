# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pm3/pm3-1.1.15.ebuild,v 1.3 2002/12/17 19:34:06 vapier Exp $

M3_TARGET="LINUXLIBC6"
MY_P="${PN}-src-${PV}"
DESCRIPTION="Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/pm3/"
SRC_URI="ftp://www.elegosoft.com/pub/pm3/${P}-${M3_TARGET}-boot.tgz
	ftp://www.elegosoft.com/pub/pm3/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl X openmotif"

DEPEND="dev-util/byacc"
RDEPEND="opengl? ( virtual/opengl )
	X? ( virtual/x11 )
	motif? ( x11-libs/openmotif )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	unpack ${P}-${M3_TARGET}-boot.tgz
	patch -p1 < ${FILESDIR}/${P}.patch || die

	echo 'RANLIB = ["ranlib"]' >> m3config/src/${M3_TARGET}
	export LD_LIBRARY_PATH="${S}/EXPORTS/usr/lib/m3/${M3_TARGET}/:${LD_LIBRARY_PATH}"
}

src_compile() {
	mv ${PN}-${M3_TARGET}/* .

	[ -n "`best_version emacs`" ] || echo SKIP_GNUEMACS=\"\" >> m3config/src/COMMON
	if [ `use opengl` ] ; then
		cp m3config/src/COMMON m3config/src/COMMON.old
		sed -e 's:PLATFORM_SUPPORTS_OPENGL:%:' m3config/src/COMMON > m3config/src/COMMON.old
	fi
	if [ `use X` ] ; then
		cp m3config/src/COMMON m3config/src/COMMON.old
		sed -e 's:PLATFORM_SUPPORTS_X:%:' m3config/src/COMMON > m3config/src/COMMON.old
	fi
	if [ `use motif` ] ; then
		cp m3config/src/COMMON m3config/src/COMMON.old
		sed -e 's:PLATFORM_SUPPORTS_MOTIF:%:' m3config/src/COMMON > m3config/src/COMMON.old
	fi

	make || die
}

src_install() {
	cd EXPORTS || die
	mkdir usr/share
	mv usr/{man,doc,share} || die
	mv * ${D}/ || die
	prepall

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/m3/${M3_TARGET}" >> 05pm3
}
