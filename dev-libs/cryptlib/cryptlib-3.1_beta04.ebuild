# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.1_beta04.ebuild,v 1.3 2004/03/14 12:28:57 mr_bones_ Exp $

MY_PV=${PV/./}; MY_PV=${MY_PV/_/}
DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/beta/cl${MY_PV}.zip
	doc? ( ftp://ftp.franken.de/pub/crypt/cryptlib/beta/manual.pdf )"

LICENSE="Sleepycat"
KEYWORDS="x86"
SLOT="0"

IUSE="static doc"

S=${WORKDIR}

src_unpack() {
	# Can't use unpack because we need the '-a' option
	unzip -qoa ${DISTDIR}/cl${MY_PV}.zip
}

src_compile() {
	export SCFLAGS="-fpic -c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	export CFLAGS="-c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	if [ `use static` ] ; then
		emake CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
			die "emake static failed"
	fi
	emake shared CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
		die "emake shared failed"
}

src_install() {
	dolib.so libcl.so*              || die "dolib.so failed"
	if [ `use static` ] ; then
		dolib.a libcl.a             || die "dolib.a failed"
	fi
	insinto /usr/include
	doins cryptlib.h                || die "doins failed"
	dodoc README                    || die "dodoc failed"
	if [ `use doc` ] ; then
		dodoc ${DISTDIR}/manual.pdf || die "dodoc failed (manual.pdf)"
	fi
}
