# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perf/perf-2.6.35_rc4.ebuild,v 1.1 2010/07/11 20:57:52 flameeyes Exp $

EAPI=2

inherit versionator eutils toolchain-funcs linux-info

MY_PV="${PV/_/-}"
MY_PV="${MY_PV/-pre/-git}"

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="http://perf.wiki.kernel.org/"

LINUX_V=$(get_version_component_range 1-2)

if [ ${PV/_rc} != ${PV} ]; then
	LINUX_VER=$(get_version_component_range 1-2).$(($(get_version_component_range 3)-1))
	PATCH_VERSION=$(get_version_component_range 1-3)
	LINUX_PATCH=patch-${PV//_/-}.bz2
	SRC_URI="mirror://kernel/linux/kernel/v${LINUX_V}/testing/${LINUX_PATCH}
		mirror://kernel/linux/kernel/v${LINUX_V}/testing/v${PATCH_VERSION}/${LINUX_PATCH}"
elif [ $(get_version_component_count) == 4 ]; then
	# stable-release series
	LINUX_VER=$(get_version_component_range 1-3)
	LINUX_PATCH=patch-${PV}.bz2
	SRC_URI="mirror://kernel/linux/kernel/v${LINUX_V}/${LINUX_PATCH}"
else
	LINUX_VER=${PV}
fi

LINUX_SOURCES=linux-${LINUX_VER}.tar.bz2
SRC_URI="${SRC_URI} mirror://kernel/linux/kernel/v${LINUX_V}/${LINUX_SOURCES}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+demangle +doc perl python"

RDEPEND="demangle? ( sys-devel/binutils )
	perl? ( || ( >=dev-lang/perl-5.10 sys-devel/libperl ) )
	python? ( dev-lang/python )
	dev-libs/elfutils"
DEPEND="${RDEPEND}
	${LINUX_PATCH+dev-util/patchutils}
	doc? ( app-text/asciidoc app-text/xmlto )"

S="${WORKDIR}/linux-${LINUX_VER}/tools/perf"

CONFIG_CHECK="~PERF_EVENTS ~KALLSYMS"

src_unpack() {
	local _tarpattern=
	local _filterdiff=
	for _pattern in {tools/perf,include,lib,"arch/*/include"}; do
		_tarpattern="${_tarpattern} linux-${LINUX_VER}/${_pattern}"
		_filterdiff="${_filterdiff} -i ${_pattern}/*"
	done

	# We expect the tar implementation to support the -j option (both
	# GNU tar and libarchive's tar support that).
	ebegin "Unpacking partial source tarball"
	tar --wildcards -xpf "${DISTDIR}"/${LINUX_SOURCES} ${_tarpattern}
	eend $? || die "tar failed"

	if [[ -n ${LINUX_PATCH} ]]; then
		ebegin "Filtering partial source patch"
		filterdiff -p1 ${_filterdiff} -z "${DISTDIR}"/${LINUX_PATCH} > ${P}.patch || die
		eend $? || die "filterdiff failed"
	fi

	MY_A=
	for _AFILE in ${A}; do
		[[ ${_AFILE} == ${LINUX_SOURCES} ]] && continue
		[[ ${_AFILE} == ${LINUX_PATCH} ]] && continue
		MY_A="${MY_A} ${_AFILE}"
	done
	[[ -n ${MY_A} ]] && unpack ${MY_A}
}

src_prepare() {
	if [[ -n ${LINUX_PATCH} ]]; then
		cd "${WORKDIR}"/linux-"${LINUX_VER}"
		epatch "${WORKDIR}"/${P}.patch
	fi

	# Drop some upstream too-developer-oriented flags and fix the
	# Makefile in general
	sed -i \
		-e 's:-Werror::' \
		-e 's:-ggdb3::' \
		-e 's:-fstack-protector-all::' \
		-e 's:^LDFLAGS =:EXTLIBS +=:' \
		-e '/\(PERL\|PYTHON\)_EMBED_LDOPTS/s:ALL_LDFLAGS +=:EXTLIBS +=:' \
		-e '/-x c - /s:\$(ALL_LDFLAGS):\0 $(EXTLIBS):' \
		-e '/^ALL_CFLAGS =/s:$: $(CFLAGS_OPTIMIZE):' \
		-e '/^ALL_LDFLAGS =/s:$: $(LDFLAGS_OPTIMIZE):' \
		"${S}"/Makefile
}

src_compile() {
	local makeargs=

	use demangle || makeargs="${makeargs} NO_DEMANGLE= "
	use perl || makeargs="${makeargs} NO_LIBPERL= "
	use perl || makeargs="${makeargs} NO_LIBPERL= "

	emake ${makeargs} \
		CC="$(tc-getCC)" AR="$(tc-getAR)" \
		prefix="/usr" bindir_relative="sbin" \
		CFLAGS_OPTIMIZE="${CFLAGS}" \
		LDFLAGS_OPTIMIZE="${LDFLAGS}" || die

	if use doc; then
		pushd Documentation
		emake ${makeargs} || die
		popd
	fi
}

src_test() {
	:
}

src_install() {
	# Don't use make install or it'll be re-building the stuff :(
	dobin perf || die

	dodoc CREDITS || die

	if use doc; then
		dodoc Documentation/*.txt || die
		dohtml Documentation/*.html || die
		doman Documentation/*.1 || die
	fi
}

pkg_postinst() {
	if ! use doc; then
		elog "Without the doc USE flag you won't get any documentation nor man pages."
		elog "And without man pages, you won't get any --help output for perf and its"
		elog "sub-tools."
	fi
}
