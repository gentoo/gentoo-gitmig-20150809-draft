# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.8.0.ebuild,v 1.1 2002/03/01 06:50:14 verwilst Exp $

S="${WORKDIR}/openh323"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/openh323_1.8.0-patched.tar.gz"
HOMEPAGE="http://www.openh323.org"

DEPEND="virtual/glibc
	>=dev-libs/pwlib-1.2.1"

src_compile() {

	cd ${S}
	export OPENH323DIR=${S}
	make opt || die

}

src_install() {

	mkdir -p ${D}/etc/env.d
	mkdir -p ${D}/usr/lib/openh323
	cd ${S}
	cp -a * ${D}/usr/lib/openh323
	cp ${FILESDIR}/11openh323 ${D}/etc/env.d

}


