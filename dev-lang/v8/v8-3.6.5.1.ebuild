# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-3.6.5.1.ebuild,v 1.2 2011/10/12 02:58:55 floppym Exp $

EAPI="4"

inherit eutils multilib pax-utils toolchain-funcs

GYP_REV="1066"

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="http://dev.gentoo.org/~floppym/distfiles/${P}.tar.xz
	http://dev.gentoo.org/~floppym/distfiles/gyp-${GYP_REV}.tar.xz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos ~x86-macos"
IUSE=""

# Avoid using python eclass since we do not need python RDEPEND
DEPEND="|| ( dev-lang/python:2.6 dev-lang/python:2.7 )"

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
	# Make /usr/bin/python (wrapper) call python2
	export EPYTHON=python2

	tc-export AR CC CXX RANLIB
	export LINK="${CXX}"

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

	emake V=1 library=shared soname_version=${PV} ${mytarget}

	pax-mark m out/${mytarget}/{cctest,d8,shell} || die
}

src_test() {
	tools/test-wrapper-gypbuild.py -j16 \
		--arch-and-mode=${mytarget} \
		--no-presubmit \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include

	dobin out/${mytarget}/d8 out/${mytarget}/shell

	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8-${PV}$(get_libname) \
			out/${mytarget}/lib.target/libv8-${PV}$(get_libname) || die
	fi

	dolib out/${mytarget}/lib.target/libv8-${PV}$(get_libname)
	dosym libv8-${PV}$(get_libname) /usr/$(get_libdir)/libv8$(get_libname)

	dodoc AUTHORS ChangeLog
}
