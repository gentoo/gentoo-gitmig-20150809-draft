# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury/mercury-10.04.ebuild,v 1.1 2010/07/19 09:25:31 keri Exp $

inherit elisp-common eutils flag-o-matic java-pkg-opt-2 multilib

MY_P=${PN}-compiler-${PV}

DESCRIPTION="Mercury is a modern general-purpose logic/functional programming language"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="http://www.mercury.cs.mu.oz.au/download/files/${MY_P}.tar.gz
	test? ( http://www.mercury.cs.mu.oz.au/download/files/mercury-tests-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="debug emacs erlang java minimal readline test threads"

DEPEND="!dev-libs/mpatrol
	!dev-util/mono-debugger
	readline? ( sys-libs/readline )
	erlang? ( dev-lang/erlang )
	java? ( >=virtual/jdk-1.5 )"

RDEPEND="${DEPEND}
	emacs? ( virtual/emacs )"

S="${WORKDIR}"/${MY_P}
TESTDIR="${WORKDIR}"/${PN}-tests-${PV}

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-multilib.patch
	epatch "${FILESDIR}"/${P}-boehm_gc.patch
	epatch "${FILESDIR}"/${P}-docs.patch
	epatch "${FILESDIR}"/${P}-no-reconf.patch

	sed -i -e "s/@libdir@/$(get_libdir)/" \
		"${S}"/compiler/make.program_target.c \
		"${S}"/scripts/Mmake.vars.in

	if use test; then
		epatch "${FILESDIR}"/${P}-tests-workspace.patch
		epatch "${FILESDIR}"/${P}-tests-sandbox.patch
	fi
}

src_compile() {
	strip-flags

	local myconf
	myconf="--libdir=/usr/$(get_libdir) \
		--disable-gcc-back-end \
		--disable-aditi-back-end \
		--disable-deep-profiler \
		--disable-dotnet-grades \
		$(use_enable erlang erlang-grade) \
		$(use_enable java java-grade) \
		$(use_enable debug debug-grades) \
		$(use_enable threads par-grades) \
		$(use_enable !minimal most-grades) \
		$(use_with readline)"

	econf \
		${myconf} \
		|| die "econf failed"
	emake \
		PARALLEL=${MAKEOPTS} \
		EXTRA_MLFLAGS=--no-strip \
		|| die "emake failed"
}

src_test() {
	TEST_GRADE=`scripts/ml --print-grade`
	TWS="${S}"

	cd "${TESTDIR}"
	sed -i -e "s:@WORKSPACE@:${TWS}:" WS_FLAGS.ws

	PATH="${TWS}"/scripts:"${TWS}"/util:"${TWS}"/slice:"${PATH}" \
	TERM="" \
	WORKSPACE="${TWS}" \
	MERCURY_COMPILER="${TWS}"/compiler/mercury_compile \
	MERCURY_CONFIG_DIR="${TWS}" \
	MMAKE_DIR="${TWS}"/scripts \
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
		PARALLEL=${MAKEOPTS} \
		MERCURY_COMPILER="${S}"/compiler/mercury_compile \
		INSTALL_PREFIX="${D}"/usr \
		INSTALL_MAN_DIR="${D}"/usr/share/man \
		INSTALL_INFO_DIR="${D}"/usr/share/info \
		INSTALL_HTML_DIR="${D}"/usr/share/doc/${PF}/html \
		INSTALL_ELISP_DIR="${D}/${SITELISP}"/${PN} \
		install || die "make install failed"

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi

	dodoc \
		BUGS HISTORY LIMITATIONS NEWS README README.Linux \
		README.Linux-Alpha README.Linux-m68k README.Linux-PPC \
		RELEASE_NOTES TODO VERSION WORK_IN_PROGRESS

	if use erlang; then
		dodoc README.Erlang
	fi

	if use java; then
		dodoc README.java
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
