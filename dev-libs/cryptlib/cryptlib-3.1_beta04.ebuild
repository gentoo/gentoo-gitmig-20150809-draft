# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.1_beta04.ebuild,v 1.1 2003/06/13 17:54:16 vapier Exp $

MY_PV=${PV/./}; MY_PV=${MY_PV/_/}
DESCRIPTION="powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/beta/cl${MY_PV}.zip
	doc? ( ftp://ftp.franken.de/pub/crypt/cryptlib/beta/manual.pdf )"

LICENSE="Sleepycat"
SLOT="0"
KEYWORDS="x86"
IUSE="static doc"

S=${WORKDIR}

src_unpack() {
	# cant use unpack cause we need the '-a' option
	unzip -qoa ${DISTDIR}/${A}
}

src_compile() {
	export SCFLAGS="-fpic -c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	export CFLAGS="-c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	if [ `use static` ] ; then
		make CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || die "could not make static"
	fi
	make shared CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || die "could not make shared"
}

src_install() {
	dolib.so libcl.so*
	use static && dolib.a libcl.a
	insinto /usr/include ; doins cryptlib.h
	dodoc README
}
