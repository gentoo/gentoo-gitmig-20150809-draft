# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perf/perf-2.6.31.ebuild,v 1.1 2009/10/30 19:30:24 flameeyes Exp $

EAPI=2

inherit versionator eutils toolchain-funcs linux-info

MY_PV="${PV/_/-}"
MY_PV="${MY_PV/-pre/-git}"

LINUX_SOURCES=linux-${MY_PV}.tar.bz2

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="http://perf.wiki.kernel.org/"
SRC_URI="mirror://kernel/linux/kernel/v$(get_version_component_range 1-2)/${LINUX_SOURCES}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+demangle"

DEPEND="demangle? ( sys-devel/binutils )
	dev-libs/elfutils"
RDEPEND="${DEPEND}"

S="${WORKDIR}/linux-${MY_PV}/tools/perf"

CONFIG_CHECK="PERF_EVENTS KALLSYMS"

src_unpack() {
	# We expect the tar implementation to support the -j option (both
	# GNU tar and libarchive's tar support that).
	tar --wildcards -xpf "${DISTDIR}"/${LINUX_SOURCES} linux-${MY_PV}/{tools/perf,include,lib,"arch/*/include"}

	[[ -n ${A/${LINUX_SOURCES}/} ]] && unpack ${A/${LINUX_SOURCES}/}
}

src_prepare() {
	# Drop some upstream too-developer-oriented flags and fix the
	# Makefile in general
	sed -i \
		-e 's:-Werror::' \
		-e 's:-ggdb3::' \
		-e 's:-fstack-protector-all::' \
		-e 's:^LDFLAGS =:EXTLIBS +=:' \
		-e '/-x c - /s:\$(ALL_LDFLAGS):\0 $(EXTLIBS):' \
		-e '/^ALL_CFLAGS =/s:$: $(CFLAGS_OPTIMIZE):' \
		-e '/^ALL_LDFLAGS =/s:$: $(LDFLAGS_OPTIMIZE):' \
		"${S}"/Makefile
}

src_compile() {
	local makeargs=

	use demangle || makeargs="${makeargs} NO_DEMANGLE= "

	emake ${makeargs} \
		CC="$(tc-getCC)" AR="$(tc-getAR)" \
		prefix="/usr" bindir_relative="sbin" \
		CFLAGS_OPTIMIZE="${CFLAGS}" \
		LDFLAGS_OPTIMIZE="${LDFLAGS}" || die
}

src_test() {
	:
}

src_install() {
	# Don't use make install or it'll be re-building the stuff :(
	dosbin perf || die

	dodoc CREDITS || die
}

pkg_postinst() {
	elog "We currently provide no documentation with perf; we're sorry"
	elog "but there will be no man page nor --help output."
}
