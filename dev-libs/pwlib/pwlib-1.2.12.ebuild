# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.2.12.ebuild,v 1.1 2002/03/01 06:48:52 verwilst Exp $

S="${WORKDIR}/pwlib"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/pwlib_1.2.12.tar.gz"
DESCRIPTION="Libs needed for GnomeMeeting"

DEPEND="virtual/glibc
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a"

src_unpack() {

	unpack pwlib_1.2.12.tar.gz
	cd ${S}/make
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff

}

src_compile() {

	export PWLIBDIR=${S}	
	cd ${S}
	make both || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/lib/pwlib
	mkdir -p ${D}/etc/env.d
	cp * ${D}/usr/lib/pwlib -a
	cp ${FILESDIR}/09pwlib ${D}/etc/env.d 

}
