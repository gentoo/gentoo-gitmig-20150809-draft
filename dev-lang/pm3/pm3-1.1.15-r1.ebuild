# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pm3/pm3-1.1.15-r1.ebuild,v 1.1 2003/04/15 13:27:24 vapier Exp $

inherit gcc eutils flag-o-matic

M3_TARGET="LINUXLIBC6"
MY_P="${PN}-src-${PV}"
DESCRIPTION="Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/pm3/"
SRC_URI="ftp://www.elegosoft.com/pub/pm3/${P}-${M3_TARGET}-boot.tgz
	ftp://www.elegosoft.com/pub/pm3/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-util/byacc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	unpack ${P}-${M3_TARGET}-boot.tgz
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/${PV}-errno.patch
	cp ${FILESDIR}/PACKAGES ${S}/src/

	echo 'RANLIB = ["ranlib"]' >> m3config/src/${M3_TARGET}
	export LD_LIBRARY_PATH="${S}/EXPORTS/usr/lib/m3/${M3_TARGET}/:${LD_LIBRARY_PATH}"

	mv ${PN}-${M3_TARGET}/* ${S}/
}

src_compile() {
	[ `gcc-major-version` == 3 ] && replace-flags -O? -O1
	make || die
}

src_install() {
	mv EXPORTS/* ${D}/ || die
	prepall

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/m3/${M3_TARGET}" >> ${D}/etc/env.d/05pm3
}
