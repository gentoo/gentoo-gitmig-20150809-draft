# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/irtrans-irclient/irtrans-irclient-5.9.07.ebuild,v 1.2 2007/12/06 21:47:18 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="IRTrans ASCII Client"
HOMEPAGE="http://www.irtrans.de"
SRC_URI="ftp://mars.arge.at/irtrans/irserver-src-${PV}.tar.gz
		http://ftp.mars.arge.at/irtrans/irserver-src-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

RDEPEND="virtual/libc"

src_unpack() {

	unpack "${A}"
	cd "${WORKDIR}"

	epatch "${FILESDIR}/${PN}"-5.9.01-missing-include.diff
}

src_compile() {

	append-flags -DLINUX -Icommon
	$(tc-getCC) "${CFLAGS}" -o irclient  client.c || die "irclient compile failed"
	$(tc-getCC) "${CFLAGS}" -o ip_assign  ip_assign.c || die "ip_assign compile failed"
}

src_install() {

	dobin "${WORKDIR}"/irclient
	dobin "${WORKDIR}"/ip_assign
}
