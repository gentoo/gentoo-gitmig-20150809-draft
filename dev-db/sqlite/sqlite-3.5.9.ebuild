# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-3.5.9.ebuild,v 1.1 2008/05/22 22:53:37 betelgeuse Exp $

EAPI="1"

inherit versionator eutils flag-o-matic libtool

DESCRIPTION="an SQL Database Engine in a C Library"
HOMEPAGE="http://www.sqlite.org/"
DOC_PV=$(replace_all_version_separators _)
SRC_URI="http://www.sqlite.org/${P}.tar.gz
	doc? ( http://www.sqlite.org/${PN}_docs_${DOC_PV}.zip )"

LICENSE="as-is"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="debug doc soundex tcl +threadsafe"
RESTRICT="!tcl? ( test )"

RDEPEND="tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"

pkg_setup() {
	# test
	if has test ${FEATURES}; then
		if ! has userpriv ${FEATURES}; then
			ewarn "The userpriv feature must be enabled to run tests."
			eerror "Testsuite will not be run."
		fi
		if ! use tcl; then
			ewarn "You must enable the tcl use flag if you want to run the testsuite."
			eerror "Testsuite will not be run."
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/sandbox-fix2.patch

	elibtoolize
	epunt_cxx
}

src_compile() {
	# not available via configure and requested in bug #143794
	use soundex && append-flags -DSQLITE_SOUNDEX=1

	econf \
		$(use_enable debug) \
		$(use_enable threadsafe) \
		$(use_enable threadsafe cross-thread-connections) \
		$(use_enable tcl) \
		|| die
	emake all || die "emake all failed"
}

src_test() {
	if use tcl ; then
		if has userpriv ${FEATURES} ; then
			if use debug ; then
				emake fulltest || die "some test failed"
			else
				emake test || die "some test failed"
			fi
		fi
	fi
}

src_install() {
	emake \
		DESTDIR="${D}" \
		TCLLIBDIR="/usr/$(get_libdir)" \
		install \
		|| die "emake install failed"

	dodoc README VERSION || die
	doman sqlite3.1 || die

	dohtml doc/*.html art/*.gif || die

	if use doc; then
		dohtml -r "${WORKDIR}"/${PN}-docs-${PV}/* || die
	fi
}

pkg_postinst() {
	einfo "lemon is not installed any more because it's an internal build tool"
}
