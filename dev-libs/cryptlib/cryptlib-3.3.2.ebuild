# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.3.2.ebuild,v 1.1 2009/01/31 00:20:57 dragonheart Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

MY_PV="${PV//.0}"
MY_PV="${MY_PV//.}"

DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
DOC_PREFIX="${PN}-3.3.2"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip
	doc? ( mirror://gentoo/${DOC_PREFIX}-manual.pdf.bz2 )"

LICENSE="Sleepycat"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc ldap odbc"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib
	ldap? ( net-nds/openldap )
	odbc? ( dev-db/unixODBC )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	# we need the -a option, so we can not use 'unpack'
	unzip -qoa "${DISTDIR}/cl${MY_PV}.zip"
	use doc && unpack "${DOC_PREFIX}-manual.pdf.bz2"
	rm -fr zlib

	# we want our own CFLAGS ;-)
	sed -i -e "s:-m.*=pentium::g" -e "s:-fomit-frame-pointer::g" -e "s:-O2::g" \
		-e "s:-O3::g" -e "s:-O4::g"	makefile || die "sed makefile failed"
	sed -i -e "s/-march=[[:alnum:]\.=-]*//g" -e "s/-mcpu=[[:alnum:]\.=-]*//g" \
		-e "s:-O2::g" -e "s:-O3::g" tools/ccopts.sh || die "sed tools/ccopts.sh failed"

	# change 'make' to '$(MAKE)'
	sed -i -e "s:@\?make:\$(MAKE):g" makefile || die "sed makefile failed"

	# NOTICE:
	# Because of stack execution
	# assembly parts are disabled.
	sed -i -e 's:i\[3,4,5,6\]86:___:g' makefile || die "sed makefile failed"

	# respect LDFLAGS and fix soname and strip issues
	epatch "${FILESDIR}/${P}-ld.patch"

	# fix build
	epatch "${FILESDIR}/${P}-pthread_yield.patch"

	# use external zlib
	epatch "${FILESDIR}/${P}-external-zlib.patch"
}

src_compile() {
	# we need at least -O2
	replace-flags -O  -O2
	replace-flags -O0 -O2
	replace-flags -O1 -O2
	replace-flags -Os -O2
	is-flagq -O* || append-flags -O2

	append-flags -c -D__UNIX__ -DNDEBUG -I.
	# QA issue for pthread_yield
	append-flags -D_GNU_SOURCE

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake static failed"

	emake shared CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake shared failed"
}

src_install() {
	dolib.so "libcl.so.3.3.2"
	dosym "libcl.so.3.3.2" "/usr/$(get_libdir)/libcl.so"
	dolib.a "libcl.a"

	insinto /usr/include
	doins cryptlib.h

	dodoc README
	use doc && newdoc "${DOC_PREFIX}-manual.pdf" "manual.pdf"
}
