# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/irtrans-irclient/irtrans-irclient-5.11.04.ebuild,v 1.3 2009/09/23 16:03:31 patrick Exp $

inherit eutils flag-o-matic toolchain-funcs

RESTRICT="strip"

DESCRIPTION="IRTrans Server"
HOMEPAGE="http://www.irtrans.de"
SRC_URI="http://ftp.mars.arge.at/irtrans/irclient-src-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND=""

src_compile() {

	append-flags -DLINUX

	# Set sane defaults (arm target has no -D flags added)
	irbuild=irclient_arm
	irclient=irclient

	# change variable by need
	if use x86 ; then
		irbuild=irclient
	elif use amd64 ; then
		irbuild=irclient64
		irclient=irclient64
	elif use arm ; then
		irbuild=irclient_arm
	fi

	# Some output for bugreport
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "Build Target=\"${irbuild}\""
	einfo "Build Binary=\"${irclient}\""

	# Build
	emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" "${irbuild}" || die "emake irclient failed"
}

src_install() {

	newbin "${WORKDIR}/${irclient}" irclient
}
