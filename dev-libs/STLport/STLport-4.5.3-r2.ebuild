# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.5.3-r2.ebuild,v 1.8 2004/01/04 17:27:55 aliz Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="C++ STL library"
SRC_URI="http://www.stlport.org/archive/${P}.tar.gz"
HOMEPAGE="http://www.stlport.org"

DEPEND="virtual/glibc"

SLOT="0"
KEYWORDS="x86 sparc amd64"
LICENSE="as-is"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Do we use the new multi scheme gcc ?
	if ! /usr/sbin/gcc-config --get-current-profile &> /dev/null
	then
		epatch ${FILESDIR}/${P}-gcc3.patch2
	fi

	epatch ${FILESDIR}/${P}-optimize.patch
}

src_compile() {
	cd src
	emake -f gcc-linux.mak || die "Compile failed"
}

src_install () {

	dodir /usr/include
	cp -R ${S}/stlport ${D}/usr/include
	rm -rf ${D}/usr/include/stlport/BC50

	dodir /usr/lib
	cp -R ${S}/lib/* ${D}/usr/lib/
	rm -rf ${D}/usr/lib/obj

	cd ${S}/etc/
	dodoc ChangeLog* README TODO *.txt

	cd ${S}
	dohtml -r doc
}

