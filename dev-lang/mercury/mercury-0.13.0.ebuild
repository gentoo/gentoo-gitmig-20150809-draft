# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury/mercury-0.13.0.ebuild,v 1.7 2006/10/19 07:20:11 keri Exp $

inherit eutils

MY_P=${PN}-compiler-${PV}

DESCRIPTION="Mercury is a modern general-purpose logic/functional programming language"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/mercury-compiler-0.13.0.tar.gz
	ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/mercury-tests-0.13.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

IUSE="debug minimal readline threads"

DEPEND="readline? ( sys-libs/readline )"

S="${WORKDIR}"/${MY_P}
TESTDIR="${WORKDIR}"/${PN}-tests-${PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-CFLAGS.patch
	epatch "${FILESDIR}"/${P}-MAKEOPTS.patch
	epatch "${FILESDIR}"/${P}-bootstrap.patch
	epatch "${FILESDIR}"/${P}-LIBDIR.patch
	epatch "${FILESDIR}"/${P}-libgrades.patch
	epatch "${FILESDIR}"/${P}-deep_profiler.patch
	epatch "${FILESDIR}"/${P}-docs.patch

	cd "${TESTDIR}"
	epatch "${FILESDIR}"/${P}-tests.patch
	sed -i -e "s:MDB_DOC:${S}/doc/mdb_doc:" mdbrc
}

src_compile() {
	local myconf
	myconf="--disable-gcc-back-end \
		--enable-aditi-back-end \
		--enable-deep-profiler \
		--disable-dotnet-grades \
		--disable-java-grades \
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
	emake \
		EXTRA_MLFLAGS=--no-strip \
		|| die "emake stage 1 failed"

	einfo "Performing stage 2 bootstrap"
	cp "${S}"/compiler/mercury_compile "${S}"/mercury_compile
	sed -i -e "s:DepFileName, \"\\\n\":DepFileName, \" \$(\", MakeVarName, \"\.cs)\\\n\":" compiler/modules.m
	econf \
		${myconf} \
		BOOTSTRAP_STAGE="2" \
		|| die "econf stage 2 failed"
	emake \
		MERCURY_COMPILER="${S}"/mercury_compile \
		depend || die "emake stage 2 depend failed"
	emake \
		MERCURY_COMPILER="${S}"/mercury_compile \
		EXTRA_MLFLAGS=--no-strip \
		|| die "emake stage 2 failed"

	einfo "Compiling libgrades"
	emake \
		MERCURY_COMPILER="${S}"/compiler/mercury_compile \
		libgrades || die "emake libgrades failed"
}

src_test() {
	cd "${S}"
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
	PATH="${TWS}"/scripts:"${TWS}"/util:"${PATH}" \
	WORKSPACE="${TWS}" \
	MERCURY_COMPILER="${TWS}"/compiler/mercury_compile \
	MMAKE_DIR="${TWS}"/scripts \
	MERCURY_DEBUGGER_INIT="${TESTDIR}"/mdbrc \
	GRADE=${TEST_GRADE} \
		mmake || die "mmake test failed"
}

src_install() {
	make \
		INSTALL_PREFIX="${D}"/usr \
		INSTALL_MAN_DIR="${D}"/usr/share/man \
		INSTALL_INFO_DIR="${D}"/usr/share/info \
		INSTALL_HTML_DIR="${D}"/usr/share/doc/${PF}/html \
		install || die "make install failed"

	dodoc \
		BUGS HISTORY LIMITATIONS NEWS README README.Linux \
		README.Linux-Alpha README.Linux-m68k README.Linux-PPC \
		RELEASE_NOTES TODO VERSION WORK_IN_PROGRESS
}
