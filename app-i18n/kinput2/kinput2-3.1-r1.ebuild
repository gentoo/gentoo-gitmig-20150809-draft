# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kinput2/kinput2-3.1-r1.ebuild,v 1.6 2004/04/06 03:56:48 vapier Exp $

inherit eutils

MY_P="${PN}-v${PV}"
DESCRIPTION="A Japanese input server which supports the XIM protocol"
HOMEPAGE="http://www.nec.co.jp/canna/"
SRC_URI="ftp://ftp.sra.co.jp/pub/x11/${PN}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE="canna freewnn"

DEPEND="virtual/glibc
	canna? >=app-i18n/canna-3.5_beta2-r1
	freewnn? ( >=app-i18n/freewnn-1.1.1_alpha19 )
	!freewnn? ( >=app-i18n/canna-3.5_beta2-r1 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	local mysed=""

	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff

	use canna \
		&& mysed="${mysed} -e 's:/\* \(\#define UseCanna\) \*/:\\1:'"
	use freewnn \
		&& mysed="${mysed} -e 's:/\* \(\#define UseWnn\) \*/:\\1:'"

	#use sj3 \
	#	&& mysed="${mysed} -e 's:/\* \(\#Define UseSj3\) \*/:\\1:'"
	#use atok \
	#	&& mysed="${mysed} -e 's:/\* \(\#Define UseAtok\) \*/:\\1:'"
	#use wnn6 \
	#	&& mysed="${mysed} -e 's:/\* \(\#Define UseWnn6\) \*/:\\1:'"

	use canna || use freewnn \
		|| mysed="${mysed} -e 's:/\* \(\#define UseCanna\) \*/:\\1:'"

	cp ${S}/Kinput2.conf ${T}
	eval sed ${mysed} ${T}/Kinput2.conf > ${S}/Kinput2.conf || die
}

src_compile() {
	xmkmf -a || die
	make CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README NEWS doc/*
	newman cmd/${PN}.man ${PN}.1
}
