# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-1.0-r1.ebuild,v 1.8 2003/04/16 11:21:19 mholzer Exp $

S=${WORKDIR}/${PN}-1.0.0.796
DESCRIPTION="A relational database offering many ANSI SQL-92 features"
SRC_URI="mirror://sourceforge/${PN}/FirebirdCS-1.0.0.796-0.tar.gz
	mirror://sourceforge/${PN}/Firebird-1.0.0.796.src.tar.gz"
HOMEPAGE="http://firebird.sourceforge.net/"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86"
DEPEND="app-shells/bash
	app-arch/zip
	>=sys-devel/gcc-2.95.3-r5"

src_unpack() {
	unpack FirebirdCS-1.0.0.796-0.tar.gz
	cd ${WORKDIR}
	unpack Firebird-1.0.0.796.src.tar.gz
	cd ${WORKDIR}/FirebirdCS-1.0.0.796-0
	tar xzf buildroot.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	export INTERBASE="${WORKDIR}/FirebirdCS-1.0.0.796-0/opt/interbase/"
	export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INTERBASE/lib"
	export FIREBIRD_64_BIT_IO="1"
	export NOPROMPT_SETUP="1"
	export GENTOO_CFLAGS=$CFLAGS
	./Configure.sh PROD || die
	cd ${S}/interbase/lib
	ln -s gds.so libgds.so
	cd ${S}
	source Configure_SetupEnv.sh
	make LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INTERBASE/lib" firebird || die
	make classictarfile || die
}

src_install () {
	dodoc README
	cd ${D}
	tar xzpf ${S}/FirebirdCS-1.0.0.796-0.64IO/buildroot.tar.gz
}
