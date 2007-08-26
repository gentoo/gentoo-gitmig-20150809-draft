# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/irtrans-irserver/irtrans-irserver-5.9.04.ebuild,v 1.1 2007/08/26 11:13:22 hd_brummy Exp $

inherit eutils flag-o-matic toolchain-funcs

RESTRICT="strip"

DESCRIPTION="IRTrans Server"
HOMEPAGE="http://www.irtrans.de"
SRC_URI="http://ftp.mars.arge.at/irtrans/irserver-src-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

RDEPEND="virtual/libc"

src_compile() {

	append-flags -DLINUX -Icommon

	if use x86 ; then
		irbuild=irserver
	elif use amd64 ; then
		irbuild=irserver64
	fi

	einfo "CFLAGS=\"${CFLAGS}\""
	emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" ${irbuild} || die "emake irserver failed"
}

src_install() {

	newbin ${WORKDIR}/${irbuild} irserver

	keepdir /etc/irserver/remotes

	docinto remotes
	dodoc remotes/*

	newinitd "${FILESDIR}"/irtrans-server.initd irtrans-server
	newconfd "${FILESDIR}"/irtrans-server.confd irtrans-server
}
