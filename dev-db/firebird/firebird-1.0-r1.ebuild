# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-1.0-r1.ebuild,v 1.4 2002/07/23 02:50:22 rphillips Exp $

S=${WORKDIR}/firebird-1.0.0.796
DESCRIPTION="Firebird is a relational database offering many ANSI SQL-92 features that runs on Linux, Windows, and a variety of Unix platforms. Firebird offers excellent concurrency, high performance, and powerful language support for stored procedures and triggers. It has been used in production systems, under a variety of names since 1981."
SRC_URI="mirror://sourceforge/firebird/FirebirdCS-1.0.0.796-0.tar.gz
	mirror://sourceforge/firebird/Firebird-1.0.0.796.src.tar.gz"
HOMEPAGE="http://firebird.sourceforge.net/"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86"
DEPEND="sys-apps/bash
	app-arch/zip
	>=sys-devel/gcc-2.95.3-r5"

src_unpack() {
	unpack FirebirdCS-1.0.0.796-0.tar.gz
	cd ${WORKDIR}
	unpack Firebird-1.0.0.796.src.tar.gz
	cd ${WORKDIR}/FirebirdCS-1.0.0.796-0
	tar xzf buildroot.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/firebird-1.0-gentoo.patch
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
