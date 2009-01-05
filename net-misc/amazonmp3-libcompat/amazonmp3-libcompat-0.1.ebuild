# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/amazonmp3-libcompat/amazonmp3-libcompat-0.1.ebuild,v 1.2 2009/01/05 18:27:01 mr_bones_ Exp $

EAPI="1"

inherit multilib eutils

BOOST_VERSION="1.34.1-7.fc8.i386"

DESCRIPTION="Support dependencies for net-misc/amazonmp3"
HOMEPAGE="http://gentoo.org/proj/en/desktop"
SRC_URI="mirror://gentoo/amazonmp3-boost-${BOOST_VERSION}.tar.bz2
	amd64? ( mirror://gentoo/${P}.tar.bz2 )"
RESTRICT="strip"

LICENSE="GPL-2"
SLOT="0"
# There are still problems with amd64 support, research on-going.
KEYWORDS="~x86 -amd64 -*"
IUSE=""

DEPEND=""
RDEPEND="x86? (
		dev-cpp/gtkmm:2.4
		net-misc/curl
		dev-libs/openssl
	)
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
	)"

S="${WORKDIR}/amazonmp3-boost-${BOOST_VERSION}"

pkg_setup() {
	if use x86 && ! built_with_use dev-cpp/gtkmm accessibility; then
		eerror "Please recompile dev-cpp/gtkmm with USE=\"accessibility\""
		die "dev-cpp/gtkmm needs accessibility USE flag"
	fi

	# 32-bit binary libs
	has_multilib_profile && ABI="x86"
}

src_install() {
	local OPTDIR="/opt/${PN}"
	exeinto "${OPTDIR}"

	# The amazonmp3 binary, compiled for Fedora 8, needs boost-1.34, so we provide a
	# set of the libs, ripped right out of their boost-1.34.1-7.fc8.i386.rpm
	doexe *

	if use amd64; then
		# gtkmm (and its deps) and libcurl are not yet available in any
		# emul-linux-x86 packages, so we rolled our own, based partially on FC8
		# gtkmm rpms.

		# TODO: Fix libcurl problems.
		pushd "${WORKDIR}/${P}"
		doexe *
		popd
	fi

	# They also need some local libraries named a bit funny:
	# TODO: Maybe put a copy of these in /opt/amazonmp3-libcompat?
	dosym "libcrypto.so" "/usr/$(get_libdir)/libcrypto.so.6"
	dosym "libssl.so" "/usr/$(get_libdir)/libssl.so.6"

	echo "LDPATH=\"${OPTDIR}\"" > 99amazonmp3-libcompat
	doenvd 99amazonmp3-libcompat
}
