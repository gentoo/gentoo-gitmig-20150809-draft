# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-3.4.14.28.ebuild,v 1.2 2011/10/06 21:27:21 floppym Exp $

EAPI="3"

inherit eutils flag-o-matic multilib pax-utils scons-utils toolchain-funcs

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~arm ~x86 ~x64-macos ~x86-macos"
IUSE="readline"

RDEPEND="readline? ( >=sys-libs/readline-6.1 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	tc-export AR CC CXX RANLIB

	# Make the build respect LDFLAGS.
	export LINKFLAGS="${LDFLAGS}"
}

src_prepare() {
	# Stop -Werror from breaking the build.
	epatch "${FILESDIR}"/${PN}-no-werror-r0.patch

	# Respect the user's CFLAGS, including the optimization level.
	epatch "${FILESDIR}"/${PN}-no-O3-r0.patch
}

src_configure() {
	# GCC issues multiple warnings about strict-aliasing issues in v8 code.
	append-flags -fno-strict-aliasing
}

src_compile() {
	local myconf="library=shared soname=on importenv=LINKFLAGS,PATH"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=x86 ;;
		x86_64-*)
			if [[ $ABI = "" ]] ; then
				myarch=amd64
			else
				myarch="$ABI"
			fi ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac

	if [[ $myarch = amd64 ]] ; then
		myconf+=" arch=x64"
	elif [[ $myarch = x86 ]] ; then
		myconf+=" arch=ia32"
	elif [[ $myarch = arm ]] ; then
		myconf+=" arch=arm"
	else
		die "Failed to determine target arch, got '$myarch'."
	fi

	escons $(use_scons readline console readline dumb) ${myconf} || die
}

src_install() {
	insinto /usr
	doins -r include || die

	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8-${PV}$(get_libname) \
			libv8-${PV}$(get_libname) || die
	fi

	dolib libv8-${PV}$(get_libname) || die
	dosym libv8-${PV}$(get_libname) /usr/$(get_libdir)/libv8$(get_libname) || die

	dodoc AUTHORS ChangeLog || die
}
