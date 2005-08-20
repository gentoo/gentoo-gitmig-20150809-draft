# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.2.1.ebuild,v 1.1 2005/08/20 08:09:58 dragonheart Exp $

inherit versionator multilib

S=${WORKDIR}
MY_PV=$(delete_all_version_separators ${PV})
DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip
	doc? ( ftp://ftp.franken.de/pub/crypt/cryptlib/manual.pdf )"

LICENSE="Sleepycat"
KEYWORDS="~x86"
SLOT="0"

IUSE="doc static"

DEPEND=">=sys-apps/sed-4
	app-arch/unzip"
RDEPEND=""

src_unpack() {
	# Can't use unpack because we need the '-a' option
	unzip -qoa ${DISTDIR}/cl${MY_PV}.zip
	sed -i -e 's/@?make/$(MAKE)/g' makefile || die "sed makefile failed"
}

src_compile() {
	export SCFLAGS="-fPIC -c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	export CFLAGS="-c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	if useq static ; then
		emake CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
			die "emake static failed"
	fi
	emake shared CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
		die "emake shared failed"
}

src_install() {
	dolib.so libcl.so.${PV}   || die "dolib.so failed"
	dosym /usr/$(get_libdir)/libcl.so.${PV} /usr/$(get_libdir)/libcl.so
	if useq static ; then
		dolib.a libcl.a             || die "dolib.a failed"
	fi
	insinto /usr/include
	doins cryptlib.h                || die "doins failed"
	dodoc README                    || die "dodoc failed"
	if useq doc ; then
		dodoc ${DISTDIR}/manual.pdf || die "dodoc failed (manual.pdf)"
	fi
}
