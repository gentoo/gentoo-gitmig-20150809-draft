# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pm3/pm3-1.1.15.ebuild,v 1.1 2002/12/17 00:09:56 vapier Exp $

M3_TARGET="LINUXLIBC6"
MY_P="${PN}-src-${PV}"
DESCRIPTION="Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/pm3/"
SRC_URI="ftp://www.elegosoft.com/pub/pm3/${P}-${M3_TARGET}-boot.tgz
	ftp://www.elegosoft.com/pub/pm3/${MY_P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-util/yacc
	app-editors/emacs"
#RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	unpack ${P}-${M3_TARGET}-boot.tgz
	patch -p1 < ${FILESDIR}/${P}.patch || die
}

src_compile() {
	mv ${PN}-${M3_TARGET}/* .

	echo 'M3CC_MAKE = ["make", "BISON=yacc"]' >> m3config/src/${M3_TARGET}
	echo 'RANLIB = ["ranlib"]' >> m3config/src/${M3_TARGET}
	export LD_LIBRARY_PATH="${S}/EXPORTS/usr/lib/m3/${M3_TARGET}/:${LD_LIBRARY_PATH}"

	make || die
}

src_install() {
	cd EXPORTS
	mkdir usr/share
	mv usr/{man,doc,share}
	mv * ${D}/
	prepall

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/m3/${M3_TARGET}" >> 05pm3
}
