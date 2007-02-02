# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-3.3.12.ebuild,v 1.2 2007/02/02 18:23:20 betelgeuse Exp $

inherit eutils alternatives libtool

DESCRIPTION="SQLite: An SQL Database Engine in a C Library"
HOMEPAGE="http://www.sqlite.org/"
SRC_URI="http://www.sqlite.org/${P}.tar.gz"

LICENSE="as-is"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nothreadsafe doc tcl test debug"

DEPEND="
	doc? ( dev-lang/tcl )
	tcl? ( dev-lang/tcl )
	test? ( dev-lang/tcl )"

RDEPEND="tcl? ( dev-lang/tcl )"

SOURCE="/usr/bin/lemon"
ALTERNATIVES="${SOURCE}-3 ${SOURCE}-0"

src_unpack() {
	# test
	if has test ${FEATURES}; then
		if ! has userpriv ${FEATURES}; then
			ewarn "The userpriv feature must be enabled to run tests."
			ewarn "Testsuite will not be run."
		fi
		if ! use test || ! use tcl; then
			eerror "The test and tcl useflags must be enabled to run tests."
			ewarn "Please note that turning on tcl installs runtime support"
			ewarn "too."
			die "test or tcl use flag disabled"
		fi
	fi

	unpack ${A}

	cd ${P}
	epatch ${FILESDIR}/sqlite-3.3.3-tcl-fix.patch
	#epatch ${FILESDIR}/sqlite-3-test-fix-3.3.4.patch

	epatch ${FILESDIR}/sandbox-fix2.patch

	# Fix broken tests that are not portable to 64 arches
	epatch ${FILESDIR}/sqlite-64bit-test-fix.patch
	epatch ${FILESDIR}/sqlite-64bit-test-fix2.patch

	elibtoolize
	epunt_cxx
}

src_compile() {
	local myconf="--enable-incore-db --enable-tempdb-in-ram --enable-cross-thread-connections"

	econf ${myconf} \
		$(use_enable !nothreadsafe threadsafe) \
		$(use_enable tcl) \
		$(use_enable debug) || die

	emake all || die

	if use doc; then
		emake doc || die
	fi
}

src_test() {
	if use test ; then
		if has userpriv ${FEATURES} ; then
			cd ${S}
			if use debug; then
				emake fulltest || die "some test failed"
			else
				emake test || die "some test failed"
			fi
		fi
	fi
}

src_install () {
	make \
		DESTDIR="${D}" \
		TCLLIBDIR="/usr/$(get_libdir)" \
		install || die

	newbin lemon lemon-${SLOT}

	dodoc README VERSION || die
	doman sqlite3.1 || die

	use doc && 	dohtml doc/* art/*.gif
}
