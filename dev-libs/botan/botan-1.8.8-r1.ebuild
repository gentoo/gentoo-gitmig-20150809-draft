# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/botan/botan-1.8.8-r1.ebuild,v 1.1 2010/01/23 15:18:58 grobian Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs

MY_PN="Botan"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://files.randombit.net/botan/${MY_P}.tgz"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~ppc-macos"
SLOT="0"
LICENSE="BSD"
IUSE="bzip2 gmp ssl threads zlib"

S="${WORKDIR}/${MY_P}"

RDEPEND="bzip2? ( >=app-arch/bzip2-1.0.5 )
	zlib? ( >=sys-libs/zlib-1.2.3 )
	gmp? ( >=dev-libs/gmp-4.2.2 )
	ssl? ( >=dev-libs/openssl-0.9.8g )"

DEPEND="${RDEPEND}
	>=dev-lang/python-2.4"

src_prepare() {
	epatch "${FILESDIR}/${P}-use_negative_lea_displacement.patch"
	epatch "${FILESDIR}"/${P}-darwin-install_name-fix.patch
}

src_configure() {
	local disable_modules="proc_walk,unix_procs,cpu_counter"

	if ! useq threads; then
		disable_modules="${disable_modules},pthreads"
	fi

	# Enable v9 instructions for sparc64
	if [[ "${PROFILE_ARCH}" = "sparc64" ]]; then
		CHOSTARCH="sparc32-v9"
	else
		CHOSTARCH="${CHOST%%-*}"
	fi

	cd "${S}"
	elog "Disabling modules: ${disable_modules}"

	local myos=
	case ${CHOST} in
		*-darwin*)   myos=darwin ;;
		*)           myos=linux  ;;
	esac

	# foobared buildsystem, --prefix translates into DESTDIR, see also make
	# install in src_install, we need the correct live-system prefix here on
	# Darwin for a shared lib with correct install_name
	./configure.py \
		--prefix="${EPREFIX}"/usr \
		--libdir=$(get_libdir) \
		--docdir=share/doc \
		--cc=gcc \
		--os=${myos} \
		--cpu=${CHOSTARCH} \
		--with-endian="$(tc-endian)" \
		--with-tr1=system \
		$(use_with bzip2) \
		$(use_with gmp gnump) \
		$(use_with ssl openssl) \
		$(use_with zlib) \
		--disable-modules=${disable_modules} \
		|| die "configure.py failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR) crs" LIB_OPT="${CXXFLAGS}" MACH_OPT="" || die "emake failed"
}

src_test() {
	chmod -R ugo+rX "${S}"
	emake CXX="$(tc-getCXX)" CHECK_OPT="${CXXFLAGS}" check || die "emake check failed"
	LD_LIBRARY_PATH="${S}" ./check --validate || die "Validation tests failed"
}

src_install() {
	emake DESTDIR="${D%/}${EPREFIX}/usr" install || die "emake install failed"
	# do the move as a two-stage operation for case-INsensitive filesystems
	mv "${D%/}${EPREFIX}"/usr/share/doc/{Botan-${PV},tbm} || die
	mv "${D%/}${EPREFIX}"/usr/share/doc/{tbm,${PF}} || die
}
