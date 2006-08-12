# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury/mercury-0.13.0_beta20060811.ebuild,v 1.2 2006/08/12 05:59:00 keri Exp $

inherit eutils versionator

BETA_V=$(get_version_component_range 4 $PV)
BETA_V_YYYY=${BETA_V:4:4}
BETA_V_MM=${BETA_V:8:2}
BETA_V_DD=${BETA_V:10:2}
MY_PV=$(get_version_component_range 1-3 $PV)-beta-${BETA_V_YYYY}-${BETA_V_MM}-${BETA_V_DD}
MY_P=${PN}-compiler-${MY_PV}

DESCRIPTION="Mercury is a modern general-purpose logic/functional programming language"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/beta-releases/0.13.0-beta/${MY_P}-unstable.tar.gz
	ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/beta-releases/0.13.0-beta/mercury-tests-${MY_PV}-unstable.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="debug minimal readline threads"

DEPEND="readline? ( sys-libs/readline )"

S="${WORKDIR}"/${MY_P}
TESTDIR="${WORKDIR}"/${PN}-tests-${MY_PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-portage.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-CFLAGS.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-bootstrap.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-LIBDIR.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-libgrades.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-docs.patch

	cd "${TESTDIR}"
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-tests.patch
	sed -i -e "s:MDB_DOC:${S}/doc/mdb_doc:" mdbrc
}

src_compile() {
	local myconf
	myconf="--disable-dotnet-grades \
		$(use_enable debug debug-grades) \
		$(use_enable threads par-grades) \
		$(use_enable !minimal most-grades) \
		$(use_with readline) \
		PACKAGE_VERSION=${PV}"

	einfo "Performing stage 1 bootstrap"
	econf \
		${myconf} \
		BOOTSTRAP_STAGE="1" \
		|| die "econf stage 1 failed"
	emake || die "emake stage 1 failed"

	einfo "Performing stage 2 bootstrap"
	cp "${S}"/compiler/mercury_compile "${S}"/mercury_compile
	econf \
		${myconf} \
		BOOTSTRAP_STAGE="2" \
		|| die "econf stage 2 failed"
	emake \
		MERCURY_COMPILER="${S}"/mercury_compile \
		|| die "emake stage 2 failed"

	einfo "Compiling libgrades"
	emake \
		MERCURY_COMPILER="${S}"/compiler/mercury_compile \
		libgrades || die "emake libgrades failed"
}

src_test() {
	cd "${TESTDIR}"

	PATH="${S}"/scripts:"${S}"/util:"${PATH}" \
	WORKSPACE="${S}" \
	MERCURY_COMPILER="${S}"/compiler/${PN}_compile \
	MMAKE_DIR="${S}"/scripts \
	MERCURY_DEBUGGER_INIT="${TESTDIR}"/mdbrc \
	mmake || die "mmake test failed"
}

src_install() {
	make \
		INSTALL_PREFIX="${D}"/usr \
		INSTALL_MAN_DIR="${D}"/usr/share/man \
		INSTALL_INFO_DIR="${D}"/usr/share/info \
		INSTALL_HTML_DIR="${D}"/usr/share/doc/${PF}/html \
		install || die "make install failed"

	dodoc BUGS HISTORY LIMITATIONS NEWS README README.Java README.Linux README.Linux-Alpha README.Linux-m68k README.Linux-PPC RELEASE_NOTES TODO VERSION WORK_IN_PROGRESS
}
