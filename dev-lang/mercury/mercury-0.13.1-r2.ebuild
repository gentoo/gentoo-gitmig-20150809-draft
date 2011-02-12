# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury/mercury-0.13.1-r2.ebuild,v 1.10 2011/02/12 18:28:00 armin76 Exp $

inherit eutils flag-o-matic

MY_P=${PN}-compiler-${PV}

DESCRIPTION="Mercury is a modern general-purpose logic/functional programming language"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/mercury-compiler-0.13.1.tar.gz
	test? ( ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/mercury-tests-0.13.1.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="debug minimal readline test threads"

DEPEND="!dev-libs/mpatrol
	!dev-util/mono-debugger
	readline? ( sys-libs/readline )"

S="${WORKDIR}"/${MY_P}
TESTDIR="${WORKDIR}"/${PN}-tests-${PV}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-mmake-params.patch
	epatch "${FILESDIR}"/${P}-multilib.patch
	epatch "${FILESDIR}"/${P}-libgrades.patch
	epatch "${FILESDIR}"/${P}-docs.patch
	epatch "${FILESDIR}"/${P}-no-reconf.patch
	epatch "${FILESDIR}"/${P}-rebuild-mslice.patch

	if use test; then
		epatch "${FILESDIR}"/${P}-tests-dir_test.patch
		epatch "${FILESDIR}"/${P}-tests-ho_and_type_spec_bug.patch
		epatch "${FILESDIR}"/${P}-tests-string_format.patch
		epatch "${FILESDIR}"/${P}-tests-workspace.patch
	fi
}

src_compile() {
	strip-flags

	local myconf
	myconf="--libdir=/usr/$(get_libdir) \
		--disable-gcc-back-end \
		--enable-aditi-back-end \
		--disable-deep-profiler \
		--disable-dotnet-grades \
		--disable-java-grades \
		--with-llds-base-grade=none \
		--with-default-grade=hlc.gc \
		$(use_enable debug debug-grades) \
		$(use_enable threads par-grades) \
		$(use_enable !minimal most-grades) \
		$(use_with readline) \
		PACKAGE_VERSION=${PV}"

	econf \
		${myconf} \
		|| die "econf failed"
	emake \
		EXTRA_MLFLAGS=--no-strip \
		|| die "emake failed"

	emake \
		MERCURY_COMPILER="${S}"/compiler/mercury_compile \
		libgrades || die "emake libgrades failed"
}

src_test() {
	TEST_GRADE=`scripts/ml --print-grade`
	if [ -d "${S}"/libgrades/${TEST_GRADE} ] ; then
		TWS="${S}"/libgrades/${TEST_GRADE}
		cp browser/mer_browser.init "${TWS}"/browser/
		cp mdbcomp/mer_mdbcomp.init "${TWS}"/mdbcomp/
		cp runtime/mer_rt.init "${TWS}"/runtime/
	else
		TWS="${S}"
	fi

	cd "${TESTDIR}"
	sed -i -e "s:@WORKSPACE@:${TWS}:" WS_FLAGS.ws

	PATH="${TWS}"/scripts:"${TWS}"/util:"${PATH}" \
	TERM="" \
	WORKSPACE="${TWS}" \
	MERCURY_COMPILER="${TWS}"/compiler/mercury_compile \
	MERCURY_CONFIG_DIR="${TWS}" \
	MMAKE_DIR="${TWS}"/scripts \
	MERCURY_DEBUGGER_INIT="${TESTDIR}"/mdbrc \
	MERCURY_SUPPRESS_STACK_TRACE=yes \
	GRADE=${TEST_GRADE} \
	MERCURY_ALL_LOCAL_C_INCL_DIRS=" -I${TWS}/boehm_gc \
					-I${TWS}/boehm_gc/include \
					-I${TWS}/runtime \
					-I${TWS}/library \
					-I${TWS}/mdbcomp \
					-I${TWS}/browser \
					-I${TWS}/trace" \
		mmake || die "mmake test failed"
}

src_install() {
	emake \
		INSTALL_PREFIX="${D}" \
		INSTALL_MAN_DIR="${D}"/usr/share/man \
		INSTALL_INFO_DIR="${D}"/usr/share/info \
		INSTALL_HTML_DIR="${D}"/usr/share/doc/${PF}/html \
		install || die "make install failed"

	dodoc \
		BUGS HISTORY LIMITATIONS NEWS README README.Linux \
		README.Linux-Alpha README.Linux-m68k README.Linux-PPC \
		RELEASE_NOTES TODO VERSION WORK_IN_PROGRESS
}
