# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.8.0.ebuild,v 1.2 2002/03/02 23:52:33 verwilst Exp $

S="${WORKDIR}/openh323"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/openh323_1.8.0-patched.tar.gz"
HOMEPAGE="http://www.openh323.org"

DEPEND="virtual/glibc
	>=dev-libs/pwlib-1.2.1-r2"

src_compile() {
	
	cd ${S}
        export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=${S}
	echo $PWLIBDIR

	make optshared || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/lib
	mkdir -p ${D}/usr/include/openh323
	cp -d lib/lib* ${D}/usr/lib
	cp -d include/*.h ${D}/usr/include/openh323
	cd ${D}/usr/lib
	ln -sf libh323_linux_x86_r.so.1.0.0a libopenh323.so
}


