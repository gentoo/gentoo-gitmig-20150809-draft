# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.2.2.ebuild,v 1.1 2005/11/02 03:38:45 sbriesen Exp $

inherit eutils multilib flag-o-matic

MY_PV=${PV//.}

DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip
	doc? ( mirror://gentoo/${P}-manual.pdf.bz2 )"

LICENSE="Sleepycat"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="doc static"

S="${WORKDIR}"

DEPEND=">=sys-apps/sed-4
	app-arch/unzip"
RDEPEND=""

src_unpack() {
	# we need the -a option, so we can not use 'unpack'
	unzip -qoa "${DISTDIR}/cl${MY_PV}.zip"
	use doc && unpack "${P}-manual.pdf.bz2"

	# we want our own CFLAGS) ;-)
	sed -i -e "s:-m.*=pentium::g" -e "s:-fomit-frame-pointer::g" -e "s:-O2::g" \
		-e "s:-O3::g" -e "s:-O4::g"	makefile || die "sed makefile failed"

	# change 'make' to '$(MAKE)'
	sed -i -e "s:@\?make:\$(MAKE):g" makefile || die "sed makefile failed"
}

src_compile() {
	# we need at least -O2
	replace-flags -O  -O2
	replace-flags -Os -O2
	replace-flags -O1 -O2
	local MYCFLAGS="-c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"

	if use static; then
		emake -j1 CFLAGS="${MYCFLAGS}" SCFLAGS="${MYCFLAGS} -fPIC" || \
			die "emake static failed"
	fi

	emake -j1 shared CFLAGS="${MYCFLAGS}" SCFLAGS="${MYCFLAGS} -fPIC" || \
		die "emake shared failed"
}

src_install() {
	dolib.so "libcl.so.${PV}"
	dosym "libcl.so.${PV}" "/usr/$(get_libdir)/libcl.so"
	use static && dolib.a "libcl.a"

	insinto /usr/include
	doins cryptlib.h

	dodoc README
	use doc && newdoc "${P}-manual.pdf" "manual.pdf"
}
