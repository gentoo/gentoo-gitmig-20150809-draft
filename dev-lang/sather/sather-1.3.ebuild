# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sather/sather-1.3.ebuild,v 1.5 2002/07/23 05:02:15 george Exp $

S="${WORKDIR}/Sather-1.3"
DESCRIPTION="Sather is an object oriented language designed to be simple, efficient, safe, flexible and non-proprietary."
SRC_URI="http://www.cs.waikato.ac.nz/sather/release/downloads/Sather-1.3.tar.gz
	ftp://ftp.gnu.org/gnu/sather/Doc/sather-tutorial-000328.ps.gz
	ftp://ftp.gnu.org/gnu/sather/Doc/sather-tutorial-000328.html.tar.gz
	ftp://ftp.gnu.org/gnu/sather/Doc/sather-specification-000328.html.tar.gz
	ftp://ftp.gnu.org/gnu/sather/Doc/sather-specification-000328.ps.gz
	http://www.icsi.berkeley.edu/~sather/Publications/satish-thatte.ps.gz
	http://www.icsi.berkeley.edu/~sather/Documentation/LanguageDescription/Descript.ps.gz"
HOMEPAGE="http://www.cs.waikato.ac.nz/sather/ http://www.icsi.berkeley.edu/~sather/"

DEPEND=">=sys-devel/gcc-2.95.3-r5
		>=dev-libs/boehm-gc-6.0"
RDEPEND=">=sys-devel/gcc-2.95.3-r5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


src_unpack() {
	unpack Sather-1.3.tar.gz
	
	mkdir doc
	cd doc
	unpack sather-tutorial-000328.html.tar.gz
	unpack sather-specification-000328.html.tar.gz
	cp ${DISTDIR}/sather-tutorial-000328.ps.gz .
	cp ${DISTDIR}/sather-specification-000328.ps.gz .
	cp ${DISTDIR}/satish-thatte.ps.gz .
	cp ${DISTDIR}/Descript.ps.gz .
}

src_compile() {

	export SATHER_HOME="$S"
	export LOCALE="en_NZ"
	export SATHER_ENV="$SATHER_HOME/resources/$LOCALE/bin/LIBCHARS-posix"
	export SATHER_RESOURCES="$SATHER_HOME/resources/$LOCALE"
	export PATH="$PATH:$SATHER_HOME/bin"
	
	./configure linux || die
	make || die

}

src_install () {

	dodir /usr
	cp -a ${WORKDIR}/Sather-1.3 ${D}/usr/sather
	rm -rf ${D}/usr/sather/bin/sacomp.code
	rm -rf ${D}/usr/sather/bin/sacomp-boot.code
	rm -rf ${D}/usr/sather/sacomp
	rm -rf ${D}/usr/sather/sacomp-boot
	rm -rf ${D}/usr/sather/system
	mkdir ${D}/usr/sather/system
	cp ${WORKDIR}/Sather-1.3/system/CONFIG ${D}/usr/sather/system
	cp ${WORKDIR}/Sather-1.3/system/FORBID ${D}/usr/sather/system
	
	cd ${WORKDIR}
	dodoc doc/sather-specification-000328.ps.gz doc/sather-tutorial-000328.ps.gz doc/satish-thatte.ps.gz doc/Descript.ps.gz
	cp -a doc/specification.html ${D}/usr/share/doc/${P}
	cp -a doc/tutorial.html ${D}/usr/share/doc/${P}
	
	dodir /etc/env.d
cat >> ${D}/etc/env.d/05sather <<EOF
SATHER_HOME="/usr/sather"
LOCALE="en_NZ"
SATHER_ENV="/usr/sather/resources/en_NZ/bin/LIBCHARS-posix"
SATHER_RESOURCES="/usr/sather/resources/en_NZ"
PATH="/usr/sather/bin"
EOF

}
