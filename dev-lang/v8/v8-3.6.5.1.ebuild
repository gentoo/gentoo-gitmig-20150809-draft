# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-3.6.5.1.ebuild,v 1.1 2011/10/09 19:45:12 floppym Exp $

EAPI="3"

inherit eutils flag-o-matic multilib pax-utils toolchain-funcs

GYP_REV="1066"

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="http://dev.gentoo.org/~floppym/distfiles/${P}.tar.xz
	http://dev.gentoo.org/~floppym/distfiles/gyp-${GYP_REV}.tar.xz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos ~x86-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	mv gyp-${GYP_REV} ${P}/build/gyp || die
}

src_prepare() {
	# Stop -Werror from breaking the build.
	sed -i -e "s/-Werror//" build/standalone.gypi || die

	# Respect the user's CFLAGS, including the optimization level.
	epatch "${FILESDIR}/v8-gyp-cflags-r0.patch"
}

src_compile() {
	tc-export AR CC CXX RANLIB
	export LINK="${CXX}"
	# Make the build respect LDFLAGS.
	export LINKFLAGS="${LDFLAGS}"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=ia32 ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch=ia32
			else
				myarch=x64
			fi ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac
	mytarget=${myarch}.release

	emake V=1 library=shared soname_version=${PV} ${mytarget} || die
}

src_test() {
	tools/test-wrapper-gypbuild.py -j16 \
		--arch-and-mode=${mytarget} \
		--no-presubmit \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include || die

	dobin out/${mytarget}/d8 out/${mytarget}/shell || die

	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8-${PV}$(get_libname) \
			out/${mytarget}/lib.target/libv8-${PV}$(get_libname) || die
	fi

	dolib out/${mytarget}/lib.target/libv8-${PV}$(get_libname) || die
	dosym libv8-${PV}$(get_libname) /usr/$(get_libdir)/libv8$(get_libname) || die

	dodoc AUTHORS ChangeLog || die
}
