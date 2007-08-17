# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/irtrans-irclient/irtrans-irclient-5.9.01.ebuild,v 1.2 2007/08/17 00:34:08 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="IRTrans ASCII Client"
HOMEPAGE="http://www.irtrans.de"
SRC_URI="ftp://mars.arge.at/irtrans/irserver-src-${PV}.tar.gz
		http://ftp.mars.arge.at/irtrans/irserver-src-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

RDEPEND="virtual/libc"

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}

	epatch ${FILESDIR}/${P}-missing-include.diff
}

src_compile() {

	append-flags -DLINUX -Icommon
	$(tc-getCC) ${CFLAGS} -o irclient  client.c || die "irclient compile failed"
}

src_install() {

	dobin ${WORKDIR}/irclient
}
